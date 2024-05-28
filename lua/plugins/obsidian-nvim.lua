local functions = require "functions"

return {
  "epwalsh/obsidian.nvim",
  -- the obsidian vault in this default config  ~/obsidian-vault
  -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
  -- event = { "BufReadPre " .. vim.fn.expand "~" .. "/second-brain/**.md" },
  ft = "*",
  event = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["gf"] = {
              function()
                if require("obsidian").util.cursor_on_markdown_link() then
                  return "<Cmd>ObsidianFollowLink<CR>"
                else
                  return "gf"
                end
              end,
              desc = "Obsidian Follow Link",
            },
            ["<leader>x"] = {
              "<Cmd>ObsidianToggleCheckbox<CR>",
              buffer = true,
              desc = "Toggle checkbox",
            },
            ["<leader>O"] = {
              name = "Obsidian",
              D = { "<Cmd>ObsidianDailies<CR>", "Dailies" },
              T = { "<Cmd>ObsidianTags<CR>", "Tags" },
              b = { "<Cmd>ObsidianBacklinks<CR>", "Backlinks" },
              c = { "<Cmd>ObsidianToggleCheckbox<CR>", "Toggle Checkbox" },
              d = { "<Cmd>ObsidianToday<CR>", "Today" },
              f = { "<Cmd>ObsidianQuickSwitch<CR>", "Find notes" },
              g = { "<Cmd>ObsidianSearch<CR>", "Grep" },
              i = { "<Cmd>ObsidianPasteImg<CR>", "Paste Image" },
              l = { "<Cmd>ObsidianLinks<CR>", "Links" },
              n = { "<Cmd>ObsidianNew<CR>", "New Note" },
              o = { "<Cmd>ObsidianOpen<CR>", "Open" },
              p = { "<Cmd>ObsidianTemplate<CR>", "Insert Template" },
              r = { "<Cmd>ObsidianRename<CR>", "Rename" },
              t = { "<Cmd>ObsidianTomorrow<CR>", "Tomorrow" },
              y = { "<Cmd>ObsidianYesterday<CR>", "Yesterday" },
            },
          },
          v = {
            ["<leader>O"] = {
              name = "Obsidian",
              e = {
                function()
                  functions.prompt_command(
                    "ObsidianExtractNote",
                    "Enter title of note to extract to (blank to use selection): ",
                    functions.getVisualSelection()
                  )
                end,
                "Extract",
              },
              l = {
                function()
                  functions.prompt_command("ObsidianLink", "Enter title of note to link to (blank to use selection): ")
                end,
                "Link",
              },
              n = {
                function()
                  functions.prompt_command("ObsidianLinkNew", "Enter title of new note (blank to use selection): ")
                end,
                "New Note",
              },
            },
          },
        },
      },
    },
  },
  opts = {
    dir = vim.env.HOME .. "/second-brain", -- specify the vault location. no need to call 'vim.fn.expand' here
    use_advanced_uri = true,
    finder = "telescope.nvim",
    note_id_func = function(title) return title end,

    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },

    notes_subdir = "inbox",

    mappings = {
      ["gf"] = {
        action = function()
          if require("obsidian").util.cursor_on_markdown_link() then
            return "<Cmd>ObsidianFollowLink<CR>"
          else
            return "gf"
          end
        end,
        opts = { noremap = false, expr = true, buffer = true },
        desc = "Obsidian Follow Link",
      },
      ["<leader>x"] = {
        action = "<Cmd>ObsidianToggleCheckbox<CR>",
        desc = "Toggle checkbox",
      },
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },

    note_frontmatter_func = function(note)
      -- This is equivalent to the default frontmatter function.
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end
      return out
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = vim.ui.open or function(url) require("astrocore").system_open(url) end,

    ui = {
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
      }
    }
  },
}
