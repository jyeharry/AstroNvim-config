-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.
-- For the full list of community plugins: https://github.com/AstroNvim/astrocommunity/tree/main/lua/astrocommunity

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.bars-and-lines.bufferline-nvim" },
  { import = "astrocommunity.bars-and-lines.lualine-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.comment.mini-comment" },
  { import = "astrocommunity.completion.cmp-cmdline" },
  { import = "astrocommunity.completion.codeium-vim" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },
  { import = "astrocommunity.git.git-blame-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.pack.astro" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.kotlin" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.swift" },
  { import = "astrocommunity.pack.typescript" },
  -- import/override with your plugins folder
}
