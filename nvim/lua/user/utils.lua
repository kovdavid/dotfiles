local M = {}

function M.get_visual_single_line()
    local _, start_line, start_col = table.unpack(vim.fn.getpos('v'))
    local _, end_line, end_col = table.unpack(vim.fn.getpos('.'))

    if start_line ~= end_line then
        return nil
    end

    local from = start_col
    local to = end_col

    if start_col > end_col then
        from = end_col
        to = start_col
    end

    local selection = vim.api.nvim_buf_get_text(0, start_line - 1, from - 1, end_line - 1, to, {})[1]

    selection = string.gsub(selection, "/", "\\/")
    selection = string.gsub(selection, "\r", "")
    selection = string.gsub(selection, "\n", "")

    return selection
end


function M.get_telescope_grep_selection(opts)
    local selection = M.get_visual_single_line()

    if selection == nil then
        print("More than 1 line selected!")
        return
    end

    if opts.full_word then
        selection = '\\b' .. selection .. '\\b'
    end

    return selection
end

return M
