local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- color scheme (-> setup in colorscheme.lua)
    { 
      "saghen/blink.cmp",
      dependencies = { "rafamadriz/friendly-snippets" },
      version = "*",
      opts = {
        keymap = {
          preset = "super-tab",
        },
        
        appearance = {
          nerd_font_variant = "mono",
        },
        
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },

        completion = {
                -- The keyword should only match against the text before
                keyword = { range = "prefix" },
                menu = {
                    -- Use treesitter to highlight the label text for the given list of sources
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                -- Show completions after typing a trigger character, defined by the source
                trigger = { show_on_trigger_character = true },
                documentation = {
                    -- Show documentation automatically
                    auto_show = true,
                },
            },
        signature = { enabled = true },
      },
      opts_extend = { "sources.default" },
    },
    { "mason-org/mason.nvim", opts = {} }, -- needed for LSP
})
