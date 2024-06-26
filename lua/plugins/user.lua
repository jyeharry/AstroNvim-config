-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      require("telescope").setup {
        pickers = {
          find_files = {
            hidden = true,
          },
          lsp_references = {
            show_line = false,
          },
        },
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",
            "--smart-case",
            "--trim",
            "--glob",
            "!.git*",
          },
          file_ignore_patterns = {
            "node_modules/",
            ".next/",
            "package-lock.json",
            "yarn.lock",
            ".git/",
          },
          cache_picker = {
            num_pickers = 50,
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-o>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              },
            },
          },
        },
      }
      require("telescope").load_extension "live_grep_args"
    end,
  },
  "nvim-telescope/telescope-live-grep-args.nvim",

  -- == Examples of Overriding Plugins ==

  -- You can disable default plugins as follows:
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "kj", "JK", "KJ" },
      }
    end,
  },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  { "echasnovski/mini.comment" },

  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      return {
        options = {
          theme = "tokyonight",
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = {
            function()
              local reg = vim.fn.reg_recording()
              if reg == "" then return "" end
              return "@" .. reg
            end,
            "diagnostics",
          },
          lualine_z = { "searchcount", "%l/%L:%c" },
        },
      }
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.mapping["<CR>"] = cmp.mapping.confirm { select = true }
    end,
  },

  {
    "Exafunction/codeium.vim",
    enabled = true,
  },

  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    opts = {
      panel = {
        auto_refresh = true,
        keymap = {
          accept = "<C-g>",
          jump_next = "<C-;>",
          jump_prev = "<C-,>",
        },
        layout = {
          position = "right",
        }
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-g>",
          accept_word = false,
          accept_line = false,
          next = "<C-;>",
          prev = "<C-,>",
          dismiss = "<C-x>",
        },
      },
    },
  },
}
