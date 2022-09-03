require'nvim-treesitter.configs'.setup {
    -- one of "all", "language", or a list of languages
    ensure_installed = {"java", "rust", "c", "cpp", "toml", "html", "css", "javascript",
    "json", "lua", "python", "vim", "yaml", "prisma", "bash"},
    highlight = {
        enable = true,           -- false will disable the whole extension
        --disable = { "rust" },  -- list of language that will be disabled
    }
}
