return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        explorer = {
            -- your explorer configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        picker = {
            explorer = {
                hidden = true,
            },
            files = {
                -- ignore = true,
                gi = true,
                hidden = true,
            },
            sources = {
                explorer = { hidden = true }
            }
        }
    }
}