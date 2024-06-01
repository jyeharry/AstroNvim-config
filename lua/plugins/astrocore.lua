-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local functions = require "functions"

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      signs = false,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        conceallevel = 1,
        foldlevel = 999,
        iskeyword = "@,48-57,192-255",
        mouse = "",
        number = true, -- sets vim.opt.number
        relativenumber = true, -- sets vim.opt.relativenumber
        scrolloff = 999,
        signcolumn = "yes", -- sets vim.opt.signcolumn to auto
        spell = false, -- sets vim.opt.spell
        virtualedit = "all",
        wrap = true, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        gitblame_delay = 20,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map
        ["-"] = { "<cmd>split<cr>", desc = "Horizontal split" },

        ["<C-c>"] = { "<cmd>bdelete<cr>", desc = "Delete buffer" },

        ["<C-/>"] = { "gccj", desc = "Comment line", remap = true },

        ["<C-.>"] = { "2<C-w>>", desc = "Increase width" },
        ["<C-,>"] = { "2<C-w><", desc = "Decrease width" },
        ["<C-+>"] = { "2<C-w>+", desc = "Increase height" },
        [""] = { "2<C-w>-", desc = "Decrease height" },

        ["<C-l>"] = { "<cmd>bnext<CR>", desc = "Next buffer" },
        ["<C-h>"] = { "<cmd>bprevious<CR>", desc = "Previous buffer" },
        ["<C-j>"] = { "<C-d>", desc = "Scroll down half a page" },
        ["<C-k>"] = { "<C-u>", desc = "Scroll up half a page" },

        H = { "^", desc = "Beginning of line" },
        L = { "$", desc = "End of line" },

        p = { "p=`]", desc = "Paste and match indentation" },
        P = { "P=`]", desc = "Paste before and match indentation" },

        ["<Leader>"] = {
          y = {
            name = "Yank",
            a = { "<cmd>let @+=expand('%:p')<CR>:echo 'Copied absolute path'<CR>", "Absolute Path" },
            r = { "<cmd>let @+=expand('%:.')<CR>:echo 'Copied relative path'<CR>", "Relative Path" },
            d = { "<cmd>let @+=expand('%:h:t')<CR>:echo 'Copied directory name'<CR>", "Directory Name" },
            f = { "<cmd>let @+=expand('%:t')<CR>:echo 'Copied filename'<CR>", "Filename" },
          },
        },

        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        ["<Leader>f"] = {
          d = {
            function()
              functions.prompt_command(
                "Telescope find_files hidden=true no_ignore=true search_dirs=%s",
                "Enter search directory: ",
                "."
              )
            end,
            "Files under Directory",
          },
          F = { "<cmd>Telescope pickers<cr>", "Telescope history" },
          g = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Grep" },
          R = { "<cmd>Telescope resume<cr>", "Resume Find" },
        },
        ["<Space>"] = { "za", desc = "Toggle fold" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        ["<Leader>u"] = {
          m = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle markdown preview" },
        },
        U = { "<C-r>", desc = "Redo" },
        zz = { "<cmd>let &l:foldlevel = indent('.') / &shiftwidth<CR>zm" },
        ["\\"] = false,
      },
      o = {
        H = { "^", desc = "Beginning of line" },
        L = { "$", desc = "End of line" },
      },
      v = {
        ["<C-/>"] = { "gc", desc = "Comment selection", remap = true },
        ["<Leader>f"] = {
          name = "Find",
          g = {
            function()
              local text = functions.getVisualSelection()
              require("telescope").extensions.live_grep_args.live_grep_args { default_text = text }
            end,
            "Grep selection",
          },
        },
        H = { "^", desc = "Beginning of line" },
        L = { "$", desc = "End of line" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
