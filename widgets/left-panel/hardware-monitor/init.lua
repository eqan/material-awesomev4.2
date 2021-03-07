local wibox = require('wibox')
local beautiful = require('beautiful')
local mat_list_item = require('widgets.mat-list-item')

local title = wibox.widget {
  text = 'Hardware monitor',
  font = beautiful.font .. ' 10',
  widget = wibox.widget.textbox
}

title = wibox.container.margin(title, 69, 12, 24, 12);

return wibox.widget {
  title,
  require('widgets.left-panel.hardware-monitor.cpu-meter'),
  require('widgets.left-panel.hardware-monitor.ram-meter'),
  require('widgets.left-panel.hardware-monitor.temperature-meter'),
  require('widgets.left-panel.hardware-monitor.harddrive-meter'),
  layout = wibox.layout.fixed.vertical
}
