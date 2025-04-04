-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.use_ime = true
config.color_scheme = 'OceanicNext (base16)'

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

-- keybindings
local act = require "wezterm".action
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1500 }
config.keys = {
  -- Send leader
  -- {
  --   key = 'LEADER|SHIFT',
  --   mods = 'Space',
  --   action = wezterm.action.SendKey { key = 'Space', mods = 'CTRL' },
  -- },

  -- Open workspace launcher
  {
    mods = 'CTRL|SHIFT',
    key = 'w',
    action = act.ShowLauncherArgs { flags = 'WORKSPACES' , title = "Select workspace" },
  },

  -- Rename workspace
  {
    mods = 'LEADER',
    key = 'r',
    action = act.PromptInputLine {
      description = '(wezterm) Set workspace title:',
      action = wezterm.action_callback(function(win,pane,line)
        if line then
          wezterm.mux.rename_workspace(
            wezterm.mux.get_active_workspace(),
            line
          )
        end
      end),
    },
  },

  -- Create new workspace
  {
    mods = 'LEADER',
    key = 'c',
    action = act.PromptInputLine {
      description = "(wezterm) Create new workspace:",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },

  {
    key = ':',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateCommandPalette,
  },

  -- Pane keybindings
  -- This will create a new split and run your default program inside it
  {
    mods = 'LEADER',
    key = 'i',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    mods = 'LEADER',
    key = '-',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  -- kill pane
  {
    mods = 'LEADER',
    key = 'x',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  -- move pane focus
  {
    mods = 'LEADER',
    key = 'h',
    action = wezterm.action.ActivatePaneDirection "Left",
  },
  {
    mods = 'LEADER',
    key = 'j',
    action = wezterm.action.ActivatePaneDirection "Down",
  },
  {
    mods = 'LEADER',
    key = 'k',
    action = wezterm.action.ActivatePaneDirection "Up",
  },
  {
    mods = 'LEADER',
    key = 'l',
    action = wezterm.action.ActivatePaneDirection "Right",
  },
  -- Move Tabs
  { key = 'h', mods = 'CTRL', action = act.ActivateTabRelative(-1) },
  { key = 'l', mods = 'CTRL', action = act.ActivateTabRelative(1) },
}

-- and finally, return the configuration to wezterm
return config