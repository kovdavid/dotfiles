P = vim.print

function _G.ReloadConfig()
    for name,_ in pairs(package.loaded) do
        if name:match('^user') then
            package.loaded[name] = nil
        end
    end

    require("user")

    vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end
