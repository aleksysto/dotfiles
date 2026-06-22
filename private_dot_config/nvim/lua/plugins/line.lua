return {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    config = function()
        require("lualine").setup({
            options = {
                -- ... other configuration
                theme = "everforest", -- Can also be "auto" to detect automatically.
            }
        })
    end,
}
