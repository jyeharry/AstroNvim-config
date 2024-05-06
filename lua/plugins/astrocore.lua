-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

function Find_files_by_input_directory()
  local user_input = vim.fn.input "Enter search directory: "
  local telescope_command = "Telescope find_files hidden=true no_ignore=true search_dirs=%s"

  if user_input ~= "" then
    vim.cmd(string.format(telescope_command, user_input))
  else
    vim.cmd(string.format(telescope_command, "."))
  end
end

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
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        foldlevel = 999,
        mouse = "",
        number = true, -- sets vim.opt.number
        relativenumber = true, -- sets vim.opt.relativenumber
        scrolloff = 999,
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        spell = false, -- sets vim.opt.spell
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

        ["<C-l>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<C-h>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<C-j>"] = { "<C-d>", desc = "Scroll down half a page" },
        ["<C-k>"] = { "<C-u>", desc = "Scroll up half a page" },

        H = { "^", desc = "Beginning of line" },
        L = { "$", desc = "End of line" },

        -- mappings seen under group name "Buffer"
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
          d = { Find_files_by_input_directory, "Files under Directory" },
          F = { "<cmd>Telescope pickers<cr>", "Telescope history" },
          g = { "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Grep" },
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
      v = {
        ["<C-/>"] = { "gc", desc = "Comment selection", remap = true },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
