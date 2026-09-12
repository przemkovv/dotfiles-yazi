require("full-border"):setup(
  {
    type = ui.Border.ROUNDED,
  })

require("session"):setup {
  sync_yanked = true,
}

-- ~/.config/yazi/init.lua
require("zoxide"):setup {
  update_db = true,
}

function Linemode:size_and_mtime()
  local time = math.floor(self._file.cha.mtime or 0)
  if time == 0 then
    time = ""
  elseif os.date("%Y", time) == os.date("%Y") then
    time = os.date("%b %d %H:%M", time)
  else
    time = os.date("%b %d  %Y", time)
  end

  local size = self._file:size()
  return string.format("%s %s", size and ya.readable_size(size) or "-", time)
end

-- You can also configure bookmarks with key arrays
local bookmarks = {
  { tag = "Desktop",   path = "~/Desktop",   key = { "d", "D" } },
  { tag = "Documents", path = "~/Documents", key = { "d", "d" } },
  { tag = "Downloads", path = "~/Downloads", key = "o" },
}

require("whoosh"):setup {
  -- Configuration bookmarks (cannot be deleted through plugin)
  bookmarks = bookmarks,

  -- Notification settings
  jump_notify = false,

  -- Key generation for auto-assigning bookmark keys
  keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

  -- Configure the built-in menu action hotkeys
  -- false - hide menu item
  special_keys = {
    create_temp = "<Enter>",      -- Create a temporary bookmark from the menu
    fuzzy_search = "<Space>",     -- Launch fuzzy search (fzf)
    history = "<Tab>",            -- Open directory history
    previous_dir = "<Backspace>", -- Jump back to the previous directory
    project_root = "-",           -- Jump to the current Git repository root
  },

  -- File path for storing user bookmarks
  bookmarks_path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\plugins\\whoosh.yazi\\bookmarks") or
      (os.getenv("HOME") .. "/.config/yazi/plugins/whoosh.yazi/bookmarks"),

  -- Replace home directory with "~"
  home_alias_enabled = true, -- Toggle home aliasing in displays

  -- Path truncation in navigation menu
  path_truncate_enabled = false, -- Enable/disable path truncation
  path_max_depth = 3,            -- Maximum path depth before truncation

  -- Path truncation in fuzzy search (fzf)
  fzf_path_truncate_enabled = false, -- Enable/disable path truncation in fzf
  fzf_path_max_depth = 5,            -- Maximum path depth before truncation in fzf

  -- Long folder name truncation
  path_truncate_long_names_enabled = false,     -- Enable in navigation menu
  fzf_path_truncate_long_names_enabled = false, -- Enable in fzf
  path_max_folder_name_length = 20,             -- Max length in navigation menu
  fzf_path_max_folder_name_length = 20,         -- Max length in fzf

  -- History directory settings
  history_size = 50,                                    -- Number of directories in history (default 10)
  history_fzf_path_truncate_enabled = false,            -- Enable/disable path truncation by depth for history
  history_fzf_path_max_depth = 5,                       -- Maximum path depth before truncation for history (default 5)
  history_fzf_path_truncate_long_names_enabled = false, -- Enable/disable long folder name truncation for history
  history_fzf_path_max_folder_name_length = 30,         -- Maximum length for folder names in history (default 30)
}
