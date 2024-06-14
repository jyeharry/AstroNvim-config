local prefix = "<Leader>T"

return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          [prefix .. "t"] = {
            function()
              require("neotest").run.run()
            end,
            desc = "Run test",
          },
          [prefix .. "f"] = {
            function()
              require("neotest").run.run(vim.fn.expand "%")
            end,
            desc = "Run all tests in file",
          },
          [prefix .. "p"] = {
            function()
              require("neotest").run.run(vim.fn.getcwd())
            end,
            desc = "Run all tests in project",
          },
          [prefix .. "c"] = { function() require("neotest").output_panel.clear() end, desc = "Clear output" },
          ["]t"] = { function() require("neotest").jump.next() end, desc = "Next test" },
          ["[t"] = { function() require("neotest").jump.prev() end, desc = "previous test" },
        },
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "neotest-jest"(require("astrocore").plugin_opts "neotest-jest"))
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = {
      summary = {
        mappings = {
          expand = { "<Space>", "<2-LeftMouse>" },
          jumpto = { "i", "<CR>" },
          mark = "m",
        },
      },
    },
  },
}
