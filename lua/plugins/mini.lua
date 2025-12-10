return {
    {
        -- Refer to: https://nvim-mini.org/mini.nvim/readmes/mini-surround.html
        "nvim-mini/mini.surround",
        config = function() 
            require("mini.surround").setup()
        end
    },
    {
        -- Refer to: https://nvim-mini.org/mini.nvim/readmes/mini-move.html
        "nvim-mini/mini.move",
        config = function() 
            require("mini.move").setup()
        end
    },
    {
        -- Refer to: https://nvim-mini.org/mini.nvim/readmes/mini-pairs.html
        "nvim-mini/mini.pairs",
        config = function() 
            require("mini.pairs").setup()
        end
    },
}
