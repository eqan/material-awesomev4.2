local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local naughty = require('naughty')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('conf.keys.mod').modKey
local altkey = require('conf.keys.mod').altKey
local apps = require('conf.apps')
-- Key bindings
local globalKeys =
  awful.util.table.join(
  -- X screen locker
  awful.key(
    {altkey, 'Control'},
    'l',
    function()
      awful.util.spawn_with_shell ('dm-tool lock')
    end,
    {description = 'lock screen', group = 'hotkeys'}
  ),
  -- Hotkeys
  awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'show help', group = 'awesome'}),
  -- Tag browsing
  awful.key({modkey}, 'Up', viewprev_nonempty_tag, {description = 'view previous', group = 'tag'}),
  awful.key({altkey, 'Control'}, 'Right', viewprev_nonempty_tag, {description = 'view previous', group = 'tag'}),
  awful.key({modkey}, 'Down', viewnext_nonempty_tag, {description = 'view next', group = 'tag'}),
  awful.key({altkey, 'Control'}, 'Left', viewnext_nonempty_tag, {description = 'view next', group = 'tag'}),
  awful.key({modkey}, 'Escape', awful.tag.history.restore, {description = 'go back', group = 'tag'}),
  -- Default client focus
  awful.key(
    {altkey},
    'Tab',
    function()
      awful.client.focus.byidx(1)
    end,
    {description = 'focus next by index', group = 'client'}
  ),
  awful.key(
    {modkey},
    'a',
    function()
      awful.client.focus.byidx(-1)
    end,
    {description = 'focus previous by index', group = 'client'}
  ),
  -- Navigate between clients
  awful.key(
    {altkey},
    'Up',
    function() awful.client.focus.bydirection('up') end,
    {description = 'focus above client'}
  ),
  awful.key(
    {altkey},
    'Down',
    function() awful.client.focus.bydirection('down') end,
    {description = 'focus below client'}
  ),
  awful.key(
    {altkey},
    'Left',
    function() awful.client.focus.bydirection('left') end,
    {description = 'focus left client'}
  ),
  awful.key(
    {altkey},
    'Right',
    function() awful.client.focus.bydirection('right') end,
    {description = 'focus right client'}
  ),
  awful.key(
    {altkey},
    'r',
    function()
      screen.primary.left_panel:toggle(true)
    end,
    {description = 'show main menu', group = 'awesome'}
  ),
  awful.key(
    {altkey},
    't',
    function()
      screen.primary.left_panel:toggle(false)
    end,
    {description = 'show left panel', group = 'awesome'}
  ),
  awful.key({modkey}, 'u', awful.client.urgent.jumpto, {description = 'jump to urgent client', group = 'client'}),
  awful.key(
    {modkey},
    'Tab',
    function()
      awful.client.focus.history.previous()
      if _G.client.focus then
        _G.client.focus:raise()
      end
    end,
    {description = 'go back', group = 'client'}
  ),
  -- Programms
  awful.key(
    {modkey},
    'l',
    function()
      awful.util.spawn_with_shell('~/.config/scripts/lock.sh')
    end
  ),
  awful.key(
    {modkey},
    'Print',
    function()
      awful.util.spawn_with_shell('scrot -e \'mv $f ~/Pictures/\'')
      naughty.notify({ text = "Screenshot saved"})
    end
  ),
    awful.key(
    {},
    'Print',
    function()
      awful.util.spawn_with_shell('maim -s | xclip -sel clipboard -t image/png')
      naughty.notify({ text = "Screenshot copied to clipboard"})
    end
  ),
  -- Standard program
  awful.key(
    {modkey},
    'Return',
    function()
      awful.spawn(apps.terminal)
    end,
    {description = 'open a terminal', group = 'launcher'}
  ),
  -- Default program
  awful.key(
    {altkey},
    'Return',
    function()
      awful.spawn(
        awful.screen.focused().selected_tag.defaultApp,
        {
          tag = _G.mouse.screen.selected_tag,
          placement = awful.placement.bottom_right
        }
      )
    end,
    {description = 'open default app', group = 'launcher'}
  ),
  awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'reload awesome', group = 'awesome'}),
  awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'quit awesome', group = 'awesome'}),
  awful.key(
    {altkey, 'Shift'},
    'l',
    function()
      awful.tag.incmwfact(0.05)
    end,
    {description = 'increase master width factor', group = 'layout'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'h',
    function()
      awful.tag.incmwfact(-0.05)
    end,
    {description = 'decrease master width factor', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'h',
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {description = 'increase the number of master clients', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'l',
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {description = 'decrease the number of master clients', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Control'},
    'h',
    function()
      awful.tag.incncol(1, nil, true)
    end,
    {description = 'increase the number of columns', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Control'},
    'l',
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    {description = 'decrease the number of columns', group = 'layout'}
  ),
  awful.key(
    {modkey},
    'space',
    function()
      awful.layout.inc(1)
    end,
    {description = 'select next', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'space',
    function()
      awful.layout.inc(-1)
    end,
    {description = 'select previous', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Control'},
    'n',
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        _G.client.focus = c
        c:raise()
      end
    end,
    {description = 'restore minimized', group = 'client'}
  ),
  -- Dropdown application
  awful.key(
    {modkey},
    '`',
    function()
      -- awful.spawn('tdrop -a gnome-terminal')
      quakeconsole[mouse.screen]:toggle()
    end,
    {description = 'dropdown application', group = 'launcher'}
  ),
  -- Widgets popups
  awful.key(
    {altkey},
    'h',
    function()
      if beautiful.fs then
        beautiful.fs.show(7)
      end
    end,
    {description = 'show filesystem', group = 'widgets'}
  ),
  awful.key(
    {altkey},
    'w',
    function()
      if beautiful.weather then
        beautiful.weather.show(7)
      end
    end,
    {description = 'show weather', group = 'widgets'}
  ),
  -- Brightness
  awful.key(
    {},
    'XF86MonBrightnessUp',
    function()
      awful.spawn('xbacklight -inc 10')
    end,
    {description = '+10%', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86MonBrightnessDown',
    function()
      awful.spawn('xbacklight -dec 10')
    end,
    {description = '-10%', group = 'hotkeys'}
  ),
  -- ALSA volume control
  awful.key(
    {},
    'XF86AudioRaiseVolume',
    function()
      awful.spawn('amixer -D pulse sset Master 5%+')
    end,
    {description = 'volume up', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioLowerVolume',
    function()
      awful.spawn('amixer -D pulse sset Master 5%-')
    end,
    {description = 'volume down', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioMute',
    function()
      awful.spawn('amixer -D pulse set Master 1+ toggle')
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioNext',
    function()
      log_this('yolo')
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86PowerDown',
    function()
      log_this('XF86PowerDown')
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86PowerOff',
    function()
      exit_screen_show()
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 0, 10 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 10 then
    descr_view = {description = 'view tag #', group = 'tag'}
    descr_toggle = {description = 'toggle tag #', group = 'tag'}
    descr_move = {description = 'move focused client to tag #', group = 'tag'}
    descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
  end
  globalKeys =
    awful.util.table.join(
    globalKeys,
    -- View tag only.
    awful.key(
      {modkey},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      descr_view
    ),
    -- Toggle tag display.
    awful.key(
      {modkey, 'Control'},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      descr_toggle
    ),
    -- Move client to tag.
    awful.key(
      {modkey, 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:move_to_tag(tag)
          end
        end
      end,
      descr_move
    ),
    -- Toggle tag on focused client.
    awful.key(
      {modkey, 'Control', 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:toggle_tag(tag)
          end
        end
      end,
      descr_toggle_focus
    )
  )
end

return globalKeys
