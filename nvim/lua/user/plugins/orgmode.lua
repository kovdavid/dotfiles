return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { "org" },
    config = function()
        require('orgmode').setup({
            org_agenda_files = '~/workspace/org-mode/**/*',
            org_default_notes_file = '~/workspace/org-mode/refile.org',
            org_capture_templates = {
                t = {
                    description = 'Todo',
                    template = '* %?\n:PROPERTIES:\n:ID: %(return require("orgmode.org.id").new())\n:CREATED: %U\n:END:\n',
                }
            },
            mappings = {
                global = {
                    org_capture = false,
                },
            }
        })
    end,
}
