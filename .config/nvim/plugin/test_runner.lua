-- New approach testing with Ginkgo

---@class Test
---@field name string
---@field line number
---@field output string[]
---@field success boolean

---@class Spec
---@field name string
---@field line number
---@field file string

local ns = vim.api.nvim_create_namespace("live-tests")

local ginkgo_spec_query = [[
  (call_expression
    (identifier) @It (#eq? @It "It")
    (argument_list
      (interpreted_string_literal) @specName
    )
  ) @spec
]]

---Parses the output of a single focused ginkgo test
---@param spec Spec
---@param data string[]
---@return Test
local parse_ginkgo_single_test_output = function(spec, data)
  local test = {}

  local has_failed = false
  local end_of_output = false
  for _, line in ipairs(data) do
    if line ~= "" then
      local decoded = vim.json.decode(line)
      -- print("=================================================================")
      -- print(decoded.Output)
      if decoded.Action == "run" or decoded.Action == "start" then
        -- print("Action:", decoded.Action)
        test = {
          name = spec.name,
          line = spec.line,
          output = {},
          success = false,
        }
      elseif decoded.Action == "pass" then
        test.success = true
      elseif decoded.Action == "fail" then
        test.success = false
      elseif decoded.Action == "output" then
        -- if output contains `[FAILED]`, start appending to the output
        if string.find(decoded.Output, "%[FAILED%]") then
          has_failed = true
        end
        if has_failed and string.find(decoded.Output, "SSSSSSSSSSSS") then
          end_of_output = true
        end
        if has_failed and not end_of_output then
          table.insert(test.output, vim.trim(decoded.Output))
        end
      end
    end
  end

  return test
end

---on_exit is called when the go test process exits. It parses the output and
---displays the results in the current buffer as virtual text
---@param bufnr number
---@param tests table<Test>
local on_exit = function(bufnr, tests)
  local failed = {}
  for _, test in pairs(tests) do
    if test.line then
      if not test.success then
        table.insert(failed, {
          bufnr = bufnr,
          lnum = test.line,
          col = 0,
          severity = vim.diagnostic.severity.ERROR,
          source = "gingkgo-test",
          message = table.concat(test.output, "\n"),
          user_data = {},
        })
      else
        local text = { "✓" }
        vim.api.nvim_buf_set_extmark(0, ns, test.line, 0, {
          virt_text = { text },
        })
      end
    end
  end

  -- TODO: parse the file and line that failed and underline the faulty line
  vim.diagnostic.set(ns, bufnr, failed, {})
end

-- test spec runs `go test ./test/ -ginkgo.focus <spec_name>` and parses the output
-- to display the results in the current buffer as virtual text
---@param spec Spec
local test_spec = function(spec)
  local command = {
    "go",
    "test",
    "./tests/",
    "-v",
    "-json",
    "-ginkgo.no-color",
    "-ginkgo.focus", spec.name,
    "-ginkgo.focus-file", spec.file,
  }
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  ---@type table<Test>
  local tests = {}

  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      tests[spec.name] = parse_ginkgo_single_test_output(spec, data)
    end,

    on_exit = function()
      on_exit(bufnr, tests)
    end,
  })
end

---test_file runs `go test ./test/ -ginkgo.focus-file <file_name>` and parses the output
---to display the results in the current buffer as virtual text
---@param filename string
local test_file = function(filename)
  local command = {
    "go",
    "test",
    "./tests/",
    "-v",
    "-json",
    "-ginkgo.no-color",
    "-ginkgo.focus-file", filename,
  }

  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  ---@type table<Test>
  local tests = {}

  vim.fn.jobstart(command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      tests[spec.name] = parse_ginkgo_single_test_output(spec, data)
    end,

    on_exit = function()
      on_exit(bufnr, tests)
    end,
  })
end

-- GinkgoRunSpec runs the spec under the cursor
vim.api.nvim_create_user_command(
  "GinkgoRunSpec",
  function()
    -- run treesitter query
    local go_bufnr = vim.api.nvim_get_current_buf()
    local query = vim.treesitter.query.parse("go", ginkgo_spec_query)
    local parser = vim.treesitter.get_parser(go_bufnr, "go", {})
    local root = parser:parse()[1]:root()

    local spec = {}
    local cursor_line = vim.fn.line(".") - 1
    local filename = vim.fn.expand("%:p")
    spec.file = filename

    for id, node in query:iter_captures(root, go_bufnr, 0, -1) do
      if id == 3 then -- the spect body
        local spec_name = string.sub(
          vim.treesitter.get_node_text(
            node:named_child(1):named_child(0),
            go_bufnr
          ),
          2, -2
        )
        local range = { node:range() }
        if cursor_line >= range[1] and cursor_line <= range[3] then
          spec.name = spec_name
          spec.line = range[1]
          break
        end
      end
    end


    if spec ~= nil and spec.line and spec.name then
      test_spec(spec)
    else
      print("not inside a spec")
    end
  end,
  {}
)
