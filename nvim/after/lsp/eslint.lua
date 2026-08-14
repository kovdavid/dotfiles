return {
    root_dir = require("user.lsp_root"),
    settings = {
        experimental = {
            useFlatConfig = os.getenv("ESLINT_FLAT_CONFIG") == 'true'
        }
    }
}
