local f = require "functions"
local prefix = "<Leader>gD"

return {
  "sindrets/diffview.nvim",
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            [prefix] = { desc = "Diffview" },
            [prefix .. "o"] = {
              function() f.prompt_command("DiffviewOpen", "Enter git revision to diff: ") end,
              desc = "Open",
            },
            [prefix .. "c"] = { "<cmd>DiffviewClose<CR>", desc = "Close" },
            [prefix .. "f"] = { 
              function() f.prompt_command("DiffviewClose", "Enter paths to diff and/or --range: ") end, desc = "File history" },
            [prefix .. "r"] = { "<cmd>DiffviewRefresh<CR>", desc = "Refresh" },
          },
        },
      },
    },
  },
}
