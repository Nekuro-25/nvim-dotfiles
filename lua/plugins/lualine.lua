-- =========================================================
-- LUALINE — statusline (menampilkan mode: showmode = false)
-- Palet ice-night, latar transparan.
-- =========================================================

local c = {
    none   = "NONE",
    fg     = "#dbe6ff",
    muted  = "#9aabe0",
    dim    = "#34447f",
    deep   = "#0d1433",
    peri   = "#8fa8f2",
    sky    = "#a8c4ff",
    teal   = "#74d6e0",
    pink   = "#f2829c",
    yellow = "#e6c987",
}

local function mode(color)
    return {
        a = { fg = c.deep, bg = color, gui = "bold" },
        b = { fg = c.fg, bg = c.dim },
        c = { fg = c.muted, bg = c.none },
    }
end

local theme = {
    normal   = mode(c.peri),
    insert   = mode(c.sky),
    visual   = mode(c.teal),
    replace  = mode(c.pink),
    command  = mode(c.yellow),
    inactive = {
        a = { fg = c.muted, bg = c.none },
        b = { fg = c.muted, bg = c.none },
        c = { fg = c.muted, bg = c.none },
    },
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
        options = {
            theme = theme,
            globalstatus = true,
            component_separators = "",
            section_separators = "",
        },
    },
}
