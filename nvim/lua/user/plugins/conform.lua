return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            c = { { "clang-format" } },
            javascript = { { "prettier" } },
            typescript = { { "prettier" } },
            javascriptreact = { { "prettier" } },
            typescriptreact = { { "prettier" } },
            html = { { "prettier" } },
            json = { { "prettier" } },
            astro = { { "prettier" } },
            -- Use the "_" filetype to run formatters on filetypes that don't
            -- have other formatters configured.
            ["_"] = { "trim_whitespace" },
        },
        formatters = {
            prettier = {
                prepend_args = function(self, ctx)
                    if os.getenv("PRETTIER_ASTRO") then
                        return { "--plugin=prettier-plugin-astro", "--plugin=prettier-plugin-tailwindcss" }
                    end
                end,
            }
        }
    }
}
