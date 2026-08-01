return {
    ["'"] = {
        {
            "''",
            when = function(ctx)
                return ctx:text_before_cursor(1) == "'"
            end,
            languages = { 'nix' },
        },
    },
    ['`'] = {
        {
            '`',
            "'",
            languages = { 'bibtex', 'latex', 'plaintex' },
        },
        {
            '`',
            enter = false,
            space = false,
            when = function(ctx)
                if ctx.ft == 'markdown' then
                    return ctx:text_before_cursor(2) ~= '``'
                elseif ctx.ft == 'typst' then
                    return ctx:text_before_cursor(2) ~= '``'
                end
                return true
            end,
        },
    },
}
