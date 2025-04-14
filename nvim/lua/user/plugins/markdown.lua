return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
        callout = {
            log = { raw = '[!LOG]', rendered = '󰥔 Log', highlight = 'RenderMarkdownInfo' },
            schedule = { raw = '[!SCHEDULE]', rendered = '󰥔 Schedule', highlight = 'RenderMarkdownSuccess' },
            schedule = { raw = '[!MEETING]', rendered = '󰥔 Meeting', highlight = 'RenderMarkdownInfo' },
        },
    }
}
