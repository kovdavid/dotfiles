return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = 'make',
        },
        {
            "danielfalk/smart-open.nvim",
            branch = "0.2.x",
            config = function()
                require("telescope").load_extension("smart_open")
            end,
            dependencies = {
                "kkharji/sqlite.lua",
                { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            },
        }
    },
    config = function(plugin, opts)
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-s>"] = "select_horizontal"
                    },
                    n = {
                        ["<C-s>"] = "select_horizontal"
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,                    -- false will only do exact matching
                    override_generic_sorter = true,  -- override the generic sorter
                    override_file_sorter = true,     -- override the file sorter
                    case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
                },
                smart_open = {
                    match_algorithm = "fzf",
                    disable_devicons = false,
                },
            }
        })

        -- To get fzf loaded and working with telescope, you need to call load_extension, somewhere after setup function:
        require('telescope').load_extension('fzf')
        require('telescope').load_extension('before')
    end
}
