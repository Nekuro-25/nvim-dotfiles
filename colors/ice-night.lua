-- ice-night: palet diambil dari wallpaper (navy + biru es; violet hanya untuk kata kunci)
-- dan sama dengan Kitty, Waybar, Rofi, Hyprland. Background TRANSPARAN supaya mengikuti terminal.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "ice-night"

local c = {
	fg = "#dbe6ff",
	comment = "#8091cc",
	purple = "#a99bf2",
	azure = "#5d80e4",
	blue = "#9fb8f5",
	teal = "#74d6e0",
	pink = "#f2829c",
	red = "#e0626a",
	yellow = "#e6c987",
	sel = "#2b3a8c",
	search = "#5a4a1e",
	line = "#1b2658",
	pop = "#121a40",
	dim = "#34447f",
	none = "NONE",
	ice = "#a8c4ff",
	muted = "#9aabe0",
	deep = "#0d1433",
}

local function hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

-- ---------------------------------------------------------
-- BASE HIGHLIGHTS (dijalankan sekali saat :colorscheme)
-- ---------------------------------------------------------

hl("Normal", { fg = c.fg, bg = c.none })
hl("NormalNC", { fg = c.fg, bg = c.none })
hl("NormalFloat", { fg = c.fg, bg = c.pop })
hl("FloatBorder", { fg = c.azure, bg = c.pop })
hl("FloatTitle", { fg = c.purple, bg = c.pop, bold = true })
hl("SignColumn", { bg = c.none })
hl("EndOfBuffer", { fg = c.none, bg = c.none })
hl("LineNr", { fg = c.comment })
hl("CursorLineNr", { fg = c.purple, bold = true })
hl("CursorLine", { bg = c.line })
hl("ColorColumn", { bg = c.line })
hl("WinSeparator", { fg = c.dim })
hl("VertSplit", { fg = c.dim })
hl("Visual", { bg = c.sel })
hl("Search", { fg = c.fg, bg = c.search })
hl("CurSearch", { fg = "#0f1638", bg = c.yellow })
hl("IncSearch", { fg = "#0f1638", bg = c.yellow })
hl("MatchParen", { fg = c.pink, bold = true, underline = true })
hl("NonText", { fg = c.dim })
hl("Whitespace", { fg = c.dim })
hl("SpecialKey", { fg = c.dim })
hl("Folded", { fg = c.comment, bg = c.line })
hl("Directory", { fg = c.blue })
hl("Title", { fg = c.purple, bold = true })
hl("Question", { fg = c.teal })
hl("MoreMsg", { fg = c.teal })
hl("ErrorMsg", { fg = c.red })
hl("WarningMsg", { fg = c.yellow })

hl("StatusLine", { fg = c.fg, bg = c.line })
hl("StatusLineNC", { fg = c.comment, bg = c.none })
hl("TabLine", { fg = c.comment, bg = c.none })
hl("TabLineSel", { fg = c.purple, bg = c.line, bold = true })
hl("TabLineFill", { bg = c.none })
hl("Pmenu", { fg = c.fg, bg = c.pop })
hl("PmenuSel", { fg = c.fg, bg = c.sel })
hl("PmenuSbar", { bg = c.line })
hl("PmenuThumb", { bg = c.azure })
hl("WildMenu", { fg = c.fg, bg = c.sel })

hl("Comment", { fg = c.comment, italic = true })
hl("Constant", { fg = c.pink })
hl("String", { fg = c.teal })
hl("Character", { fg = c.teal })
hl("Number", { fg = c.pink })
hl("Boolean", { fg = c.pink })
hl("Float", { fg = c.pink })
hl("Identifier", { fg = c.fg })
hl("Function", { fg = c.blue })
hl("Statement", { fg = c.purple })
hl("Conditional", { fg = c.purple })
hl("Repeat", { fg = c.purple })
hl("Label", { fg = c.purple })
hl("Operator", { fg = c.blue })
hl("Keyword", { fg = c.purple, italic = true })
hl("Exception", { fg = c.purple })
hl("PreProc", { fg = c.azure })
hl("Include", { fg = c.purple })
hl("Define", { fg = c.purple })
hl("Macro", { fg = c.azure })
hl("Type", { fg = c.yellow })
hl("StorageClass", { fg = c.yellow })
hl("Structure", { fg = c.yellow })
hl("Typedef", { fg = c.yellow })
hl("Special", { fg = c.pink })
hl("SpecialChar", { fg = c.pink })
hl("Delimiter", { fg = "#96a7dc" })
hl("Tag", { fg = c.purple })
hl("Underlined", { fg = c.blue, underline = true })
hl("Error", { fg = c.red })
hl("Todo", { fg = "#0f1638", bg = c.yellow, bold = true })

hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.pink, italic = true })
hl("@variable.parameter", { fg = "#d8c4ff" })
hl("@property", { fg = "#b4a7f5" })
hl("@constructor", { fg = c.yellow })
hl("@function.builtin", { fg = c.blue, italic = true })
hl("@tag", { fg = c.purple })
hl("@tag.attribute", { fg = c.blue, italic = true })
hl("@tag.delimiter", { fg = "#96a7dc" })
hl("@string.special.url", { fg = c.teal, underline = true })
hl("@markup.heading", { fg = c.purple, bold = true })
hl("@markup.strong", { bold = true })
hl("@markup.italic", { italic = true })
hl("@markup.raw", { fg = c.teal })
hl("@markup.link.url", { fg = c.blue, underline = true })
hl("@markup.list", { fg = c.pink })

hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn", { fg = c.yellow })
hl("DiagnosticInfo", { fg = c.blue })
hl("DiagnosticHint", { fg = c.teal })
hl("DiagnosticOk", { fg = c.teal })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.teal })

hl("DiffAdd", { bg = "#103a44" })
hl("DiffChange", { bg = "#222f6a" })
hl("DiffDelete", { fg = c.red, bg = "#3d1a2a" })
hl("DiffText", { bg = "#2b3a8c" })
hl("Added", { fg = c.teal })
hl("Changed", { fg = c.yellow })
hl("Removed", { fg = c.red })

hl("DiagnosticVirtualTextError", { fg = c.red })
hl("DiagnosticVirtualTextWarn", { fg = c.yellow })
hl("DiagnosticVirtualTextInfo", { fg = c.blue })
hl("DiagnosticVirtualTextHint", { fg = c.teal })
hl("DiagnosticUnnecessary", { fg = c.comment })
hl("LspReferenceText", { bg = c.sel })
hl("LspReferenceRead", { bg = c.sel })
hl("LspReferenceWrite", { bg = c.sel, underline = true })
hl("LspInlayHint", { fg = c.comment, italic = true })
hl("LspSignatureActiveParameter", { fg = c.yellow, bold = true })
hl("MsgArea", { fg = c.fg, bg = c.none })
hl("SpellBad", { undercurl = true, sp = c.red })
hl("SpellCap", { undercurl = true, sp = c.yellow })

local ansi = {
	"#1b2658",
	"#e0626a",
	"#86d6a8",
	"#e6c987",
	"#6f8fee",
	"#a99bf2",
	"#74d6e0",
	"#dbe6ff",
	"#7689c5",
	"#f2829c",
	"#a8ecc4",
	"#f2dca4",
	"#a8c4ff",
	"#bfaeff",
	"#9aeaf2",
	"#f0f5ff",
}
for i, color in ipairs(ansi) do
	vim.g["terminal_color_" .. (i - 1)] = color
end

-- ---------------------------------------------------------
-- PLUGIN HIGHLIGHTS
-- Plugin lazy-load bisa menimpa grup ini saat dimuat. Fungsi ini dipanggil ulang
-- pada User VeryLazy dan User LazyLoad supaya warna ice-night tetap menang.
-- Biayanya sangat murah (puluhan nvim_set_hl), aman dipanggil berulang.
-- ---------------------------------------------------------
local function apply_plugin_highlights()
	-- Telescope
	hl("TelescopeNormal", { fg = c.fg, bg = c.pop })
	hl("TelescopeBorder", { fg = c.azure, bg = c.pop })
	hl("TelescopePromptNormal", { fg = c.fg, bg = c.line })
	hl("TelescopePromptBorder", { fg = c.line, bg = c.line })
	hl("TelescopePromptTitle", { fg = c.deep, bg = c.ice, bold = true })
	hl("TelescopeResultsTitle", { fg = c.deep, bg = c.blue, bold = true })
	hl("TelescopePreviewTitle", { fg = c.deep, bg = c.teal, bold = true })
	hl("TelescopePromptPrefix", { fg = c.azure })
	hl("TelescopeSelection", { fg = c.fg, bg = c.sel })
	hl("TelescopeSelectionCaret", { fg = c.ice, bg = c.sel })
	hl("TelescopeMatching", { fg = c.ice, bold = true })

	-- Blink.cmp
	hl("BlinkCmpMenu", { fg = c.fg, bg = c.pop })
	hl("BlinkCmpMenuBorder", { fg = c.azure, bg = c.pop })
	hl("BlinkCmpMenuSelection", { bg = c.sel })
	hl("BlinkCmpDoc", { fg = c.fg, bg = c.pop })
	hl("BlinkCmpDocBorder", { fg = c.azure, bg = c.pop })
	hl("BlinkCmpGhostText", { fg = c.comment, italic = true })
	hl("BlinkCmpLabelMatch", { fg = c.ice, bold = true })
	hl("BlinkCmpLabelDeprecated", { fg = c.comment, strikethrough = true })

	-- Gitsigns
	hl("GitSignsAdd", { fg = c.teal })
	hl("GitSignsChange", { fg = c.yellow })
	hl("GitSignsDelete", { fg = c.red })

	-- Indent blankline
	hl("IblIndent", { fg = "#222f6a" })
	hl("IblScope", { fg = c.azure })

	-- Which-key
	hl("WhichKey", { fg = c.ice })
	hl("WhichKeyGroup", { fg = c.purple })
	hl("WhichKeyDesc", { fg = c.fg })
	hl("WhichKeySeparator", { fg = c.dim })
	hl("WhichKeyNormal", { bg = c.pop })

	-- DAP
	hl("DapBreakpoint", { fg = c.red })
	hl("DapStopped", { fg = c.yellow })
	hl("DapStoppedLine", { bg = "#2b3a8c" })

	-- Render markdown
	hl("RenderMarkdownCode", { bg = c.pop })
	hl("RenderMarkdownCodeInline", { fg = c.teal, bg = c.line })

	-- Lazy / Mason
	hl("LazyNormal", { link = "NormalFloat" })
	hl("MasonNormal", { link = "NormalFloat" })
end

apply_plugin_highlights()

local aug = vim.api.nvim_create_augroup("ice_night_highlights", { clear = true })
vim.api.nvim_create_autocmd("User", {
	group = aug,
	pattern = { "VeryLazy", "LazyLoad" },
	callback = apply_plugin_highlights,
})
