vim.pack.add({
  vim.g.local_plugin .. "gruvbox.nvim",
  vim.g.local_plugin .. "lualine.nvim",
})

local gruvbox = require("gruvbox")

local colors = {
    bg0    = gruvbox.palette.dark0,
    bg1    = gruvbox.palette.dark1,
    bg2    = gruvbox.palette.dark2,
    bg3    = gruvbox.palette.dark3,
    bg4    = gruvbox.palette.dark4,
    fg1    = gruvbox.palette.light1,
    fg4    = gruvbox.palette.light4,
    red    = gruvbox.palette.bright_red,
    green  = gruvbox.palette.bright_green,
    yellow = gruvbox.palette.bright_yellow,
    blue   = gruvbox.palette.bright_blue,
    aqua   = gruvbox.palette.bright_aqua,
    orange = gruvbox.palette.bright_orange,
}

local statusline_theme = {
  normal = {
    a = { bg = colors.fg4, fg = colors.bg0, gui = 'bold' },
    b = { bg = colors.bg2, fg = colors.fg1 },
    c = { bg = colors.bg1, fg = colors.fg4 },
  },
  insert = {
    a = { bg = colors.blue, fg = colors.bg0, gui = 'bold' },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.bg0, gui = 'bold' },
  },
  replace = {
    a = { bg = colors.red, fg = colors.bg0, gui = 'bold' },
  },
  command = {
    a = { bg = colors.green, fg = colors.bg0, gui = 'bold' },
  },
  inactive = {
    a = { bg = colors.bg4, fg = colors.bg0, gui = 'bold' },
    b = { bg = colors.bg1, fg = colors.bg3 },
    c = { bg = colors.bg1, fg = colors.bg3 },
  },
}

local function fugitive_branch()
  local icon = '' -- e0a0
  return icon .. ' ' .. vim.fn.FugitiveHead()
end

local function window_nr()
  return vim.fn.winnr()
end

local base_a = {
  {
    window_nr,
    padding = 1,
    separator = { right = '', },
  },
}

local help = {
  sections = {
    lualine_a = base_a,
    lualine_c = {
      {
        'filetype',
      },
      {
        'filename',
        file_status = false,
      },
    },
    lualine_x = { 'progress' },
  },
  filetypes = { 'help' }
}

local title = {
  alpha = function() return 'Startify' end,
  netrw = function() return 'Explorer' end,
  terminal = function() return 'Terminal' end,
  fugitive = function() return fugitive_branch() end,
}

local simple = {
  sections = {
    lualine_a = base_a,
    lualine_c = {
      function()
        return title[vim.bo.filetype]() or "Unknown"
      end
    },
  },
  filetypes = { 'alpha', 'fugitive', 'netrw', 'terminal' }
}

local statusline_config = {
  options = {
    theme = statusline_theme,
  },
  sections = {
    lualine_a = {
      {
        'mode',
        separator = '',
      },
      {
        function() return vim.fn.winnr() end,
        padding = { left = 0, right = 1 },
      },
    },
    lualine_c = {
      {
        'filename',
        file_status = false,
        color = function()
          if vim.bo.modified then
            return { fg = colors.red }
          elseif not vim.bo.modifiable then
            return { fg = colors.green }
          end
        end
      },
    },
    lualine_x = {
      {
        'filetype',
        separator = '|'
      },
      {
        'encoding',
        separator = '|'
      },
      {
        'fileformat'
      },
    },
    lualine_y = {
      {
        'location',
        icons_enabled = false,
        padding = 1,
      },
      {
        'progress',
      },
    },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = base_a,
    lualine_c = {
      {
        'filetype',
      },
      {
        'filename',
        file_status = false,
        color = function()
          if vim.bo.modified then
            return { fg = colors.red }
          else
            return 'lualine_c_inactive'
          end
        end
      },
    },
    lualine_x = { 'progress' },
  },
  extensions = { help, simple },
}

gruvbox.setup()
vim.opt.background = "dark"
vim.cmd([[colorscheme gruvbox]])

require('lualine').setup(statusline_config)
