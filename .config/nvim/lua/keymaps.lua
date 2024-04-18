local keymap = vim.keymap

vim.g.mapleader = ","

-- Make certain motions keep cursor in the middle
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "n", "nzz")
keymap.set("n", "N", "Nzz")

-- Don't move cursor when using J to join lines
keymap.set("n", "J", "mzJ`z")

-- Don't leave visual mode after indenting
keymap.set("v", ">", ">gv^")
keymap.set("v", "<", "<gv^")

-- Apply the . command to all selected lines in visual mode
keymap.set("v", ".", ":normal .<CR>", { silent = true })

-- Previous/next buffer
keymap.set("n", "[b", "<CMD>bprevious<CR>")
keymap.set("n", "]b", "<CMD>bnext<CR>")

-- Previous/next tab
keymap.set("n", "[t", "<CMD>tabprevious<CR>")
keymap.set("n", "]t", "<CMD>tabnext<CR>")

-- Move current tab
keymap.set("n", "[T", "<CMD>tabmove -1<CR>")
keymap.set("n", "]T", "<CMD>tabmove +1<CR>")

-- Disable arrow keys
keymap.set({ "n", "i" }, "<Left>", "<Nop>")
keymap.set({ "n", "i" }, "<Right>", "<Nop>")
keymap.set({ "n", "i" }, "<Up>", "<Nop>")
keymap.set({ "n", "i" }, "<Down>", "<Nop>")

vim.cmd([[
nnoremap <Esc> <cmd>nohlsearch<CR>

nnoremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <silent><A-l> <cmd>bn<CR>
nnoremap <silent><A-h> <cmd>bp<CR>
nnoremap <silent><A-d> <cmd>Bd<CR>
nnoremap <silent><S-A-d> <cmd>bw<CR>
nnoremap <silent>]b <cmd>bn<CR>
nnoremap <silent>[b <cmd>bp<CR>

nnoremap <silent>]q <cmd>cnext<CR>
nnoremap <silent>[q <cmd>cprev<CR>
nnoremap <silent>]Q <cmd>cfirst<CR>
nnoremap <silent>[Q <cmd>clast<CR>

" jump to next git conflict marker (<<<<<<<)
nnoremap <silent>[n /^\(<<<<<<<\\|=======\\|>>>>>>>\)<CR>
nnoremap <silent>]n ?^\(<<<<<<<\\|=======\\|>>>>>>>\)<CR>

tnoremap <Esc> <C-\><C-n>
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

" center the screen after jumping
nnoremap {  {zz
nnoremap }  }zz
nnoremap n  nzzzv
nnoremap N  Nzzzv
nnoremap ]c ]czz
nnoremap [c [czz
nnoremap [j <C-o>zz
nnoremap ]j <C-i>zz
nnoremap ]s ]szz
nnoremap [s [szz

" move the selected text up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" I don't remember what this does, but it conflics with the gf for lua "require"
" nnoremap gf <cmd>e <cfile><cr>

" paste from clipboard keeping indentation
inoremap <M-p> <C-r><C-o>"
nnoremap <M-p> <C-r><C-o>"

" copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" start replacing the word under the cursor, appendint text to it
nnoremap <leader>s :%s/<C-r><C-w>/<C-r><C-w>/g<left><left>
" replace the word under the cursor
nnoremap <leader>S :%s/<C-r><C-w>//g<left><left>

" search the word under the cursor, but don't jump to it
noremap * :let @/ = "\\<<C-r><C-w>\\>"<cr>:set hlsearch<cr>

" open stuff in vertical split window
nnoremap <c-w>F <c-w>vgf
nnoremap <c-w>[ <c-w>v<c-]>
]])
