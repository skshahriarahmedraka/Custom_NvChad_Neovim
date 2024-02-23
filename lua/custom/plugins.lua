local overrides = require "custom.configs.overrides"
local plugins  = {
  {
    "vim-crystal/vim-crystal",
    ft = "crystal",
    config = function (_)
      vim.g.crystal_auto_format =1
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },

  --#region

 {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require "plugins.configs.lspconfig"
  --     require "custom.configs.lspconfig"
  --   end,
  -- },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   ft = "go",
  --   opts = function()
  --     return require "custom.configs.null-ls"
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
      require("core.utils").load_mappings("gopher")
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "yochem/cmp-htmx"
    },
    config = {
        sources = require('cmp').config.sources({
            { name = "cmp-htmx" }
        })
    }
  },
-- {
--   "https://git.sr.ht/~nedia/auto-save.nvim",
--   event = { "BufReadPre" },
--   opts = {
--     events = { 'InsertLeave', 'BufLeave', 'TextChanged' },
--     silent = false,
--     exclude_ft = { 'neo-tree' },
--   },
-- },


  -- {
  --   "okuuva/auto-save.nvim",
  --   cmd = "ASToggle", -- optional for lazy loading on command
  --   event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  --   opts = {
  --   enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
  --   execution_message = {
  --     enabled = true,
  --     message = function() -- message to print on save
  --       return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
  --     end,
  --     dim = 0.18, -- dim the color of `message`
  --     cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
  --   },
  --
  --   trigger_events = { -- See :h events
  --     immediate_save = { "BufLeave", "FocusLost", "BufReadPre" }, -- vim events that trigger an immediate save
  --     defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
  --     cancel_defered_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
  --   },
  --   -- function that takes the buffer handle and determines whether to save the current buffer or not
  --   -- return true: if buffer is ok to be saved
  --   -- return false: if it's not ok to be saved
  --   -- if set to `nil` then no specific condition is applied
  --   condition = nil,
  --   write_all_buffers = false, -- write all buffers when the current one meets `condition`
  --   noautocmd = false, -- do not execute autocmds when saving
  --   debounce_delay = 1000, -- delay after which a pending save is executed
  --  -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
  --   debug = false,
  --   }
  -- },
  {
    "Pocco81/AutoSave.nvim",
    module = "autosave",
    lazy = false,
    config = function()
      require("custom.configs.overrides").autosave()
    end,
   },

 {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require "custom.configs.better-escape"
    end,
  },

  {
    "tpope/vim-surround",
    event = "BufReadPost",
  },
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require "custom.configs.illuminate"
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPost",
    config = function()
      require "custom.configs.neoscroll"
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = overrides.gitsigns,
  },
}

return plugins
