local prefix = "<Leader>x"

return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              [prefix] = { desc = require("astroui").get_icon("Trouble", 1, true) .. "Trouble" },
              [prefix .. "l"] = { "<Cmd>Trouble lsp toggle<CR>", desc = "LSP References" },
              [prefix .. "L"] = { "<Cmd>Trouble lsp_document_symbols toggle win.position=right<CR>", desc = "LSP Document Symbols" },
            },
          },
        },
      },
    },
  },
}
