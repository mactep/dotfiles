local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local HOME = os.getenv("HOME")
local ICON_DIR = HOME .. "/.config/awesome/themes/default/icons/"

local redshift_widget = wibox.widget({
    {
        {
            image = ICON_DIR .. "lightbulb-solid.svg",
            resize = true,
            widget = wibox.widget.imagebox,
        },
        margins = 2,
        layout = wibox.container.margin,
    },
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 4)
    end,
    widget = wibox.container.background,
})

local function worker()
    local active = false

    local on = function()
        awful.spawn.with_shell("redshift -O 2800")
        active = true
    end
    local off = function()
        awful.spawn.with_shell("redshift -x")
        active = false
    end

    redshift_widget:buttons(awful.util.table.join(awful.button({}, 1, function()
        if active then
            off()
        else
            on()
        end
    end)))

    return redshift_widget
end

return worker
