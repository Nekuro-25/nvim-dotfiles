-- ice-night: tema buatan sendiri, palet diambil dari wallpaper (navy + biru es,
-- violet hanya sebagai aksen kata kunci) dan terminal Kitty. Background TRANSPARAN supaya mengikuti terminal.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.o.background = "dark"
vim.g.colors_name = "ice-night"

local c = {
  fg        = "#dbe6ff",
  comment   = "#8091cc",
  purple    = "#a99bf2", -- keyword
  azure     = "#5d80e4", -- biru utama
  blue      = "#9fb8f5", -- function
  teal      = "#74d6e0", -- string
  pink      = "#f2829c", -- angka / konstanta
  red       = "#e0626a",  -- error
  yellow    = "#e6c987", -- warning / type
  sel       = "#2b3a8c", -- seleksi
  search = "#5a4a1e",   -- latar hasil pencarian (amber gelap), beda dari Visual
  line      = "#1b2658", -- cursorline
  pop       = "#121a40", -- popup
  dim       = "#34447f", -- garis pemisah
  none      = "NONE",
}

local function hl(name, opts) vim.api.nvim_set_hl(0, name, opts) end

-- Dasar (transparan)
hl("Normal",       { fg = c.fg, bg = c.none })
hl("NormalNC",     { fg = c.fg, bg = c.none })
hl("NormalFloat",  { fg = c.fg, bg = c.pop })
hl("FloatBorder",  { fg = c.azure, bg = c.pop })
hl("FloatTitle",   { fg = c.purple, bg = c.pop, bold = true })
hl("SignColumn",   { bg = c.none })
hl("EndOfBuffer",  { fg = c.none, bg = c.none })
hl("LineNr",       { fg = c.comment })
hl("CursorLineNr", { fg = c.purple, bold = true })
hl("CursorLine",   { bg = c.line })
hl("ColorColumn",  { bg = c.line })
hl("WinSeparator", { fg = c.dim })
hl("VertSplit",    { fg = c.dim })
hl("Visual",       { bg = c.sel })
hl("Search", { fg = c.fg, bg = c.search })
hl("CurSearch",    { fg = "#0f1638", bg = c.yellow })
hl("IncSearch",    { fg = "#0f1638", bg = c.yellow })
hl("MatchParen",   { fg = c.pink, bold = true, underline = true })
hl("NonText",      { fg = c.dim })
hl("Whitespace",   { fg = c.dim })
hl("SpecialKey",   { fg = c.dim })
hl("Folded",       { fg = c.comment, bg = c.line })
hl("Directory",    { fg = c.blue })
hl("Title",        { fg = c.purple, bold = true })
hl("Question",     { fg = c.teal })
hl("MoreMsg",      { fg = c.teal })
hl("ErrorMsg",     { fg = c.red })
hl("WarningMsg",   { fg = c.yellow })

-- Statusline, menu, popup
hl("StatusLine",   { fg = c.fg, bg = c.line })
hl("StatusLineNC", { fg = c.comment, bg = c.none })
hl("TabLine",      { fg = c.comment, bg = c.none })
hl("TabLineSel",   { fg = c.purple, bg = c.line, bold = true })
hl("TabLineFill",  { bg = c.none })
hl("Pmenu",        { fg = c.fg, bg = c.pop })
hl("PmenuSel",     { fg = c.fg, bg = c.sel })
hl("PmenuSbar",    { bg = c.line })
hl("PmenuThumb",   { bg = c.azure })
hl("WildMenu",     { fg = c.fg, bg = c.sel })

-- Sintaks klasik
hl("Comment",      { fg = c.comment, italic = true })
hl("Constant",     { fg = c.pink })
hl("String",       { fg = c.teal })
hl("Character",    { fg = c.teal })
hl("Number",       { fg = c.pink })
hl("Boolean",      { fg = c.pink })
hl("Float",        { fg = c.pink })
hl("Identifier",   { fg = c.fg })
hl("Function",     { fg = c.blue })
hl("Statement",    { fg = c.purple })
hl("Conditional",  { fg = c.purple })
hl("Repeat",       { fg = c.purple })
hl("Label",        { fg = c.purple })
hl("Operator",     { fg = c.blue })
hl("Keyword",      { fg = c.purple, italic = true })
hl("Exception",    { fg = c.purple })
hl("PreProc",      { fg = c.azure })
hl("Include",      { fg = c.purple })
hl("Define",       { fg = c.purple })
hl("Macro",        { fg = c.azure })
hl("Type",         { fg = c.yellow })
hl("StorageClass", { fg = c.yellow })
hl("Structure",    { fg = c.yellow })
hl("Typedef",      { fg = c.yellow })
hl("Special",      { fg = c.pink })
hl("SpecialChar",  { fg = c.pink })
hl("Delimiter",    { fg = "#96a7dc" })
hl("Tag",          { fg = c.purple })
hl("Underlined",   { fg = c.blue, underline = true })
hl("Error",        { fg = c.red })
hl("Todo",         { fg = "#0f1638", bg = c.yellow, bold = true })

-- Treesitter (HTML / CSS / JS / Python / Markdown)
hl("@variable",            { fg = c.fg })
hl("@variable.builtin",    { fg = c.pink, italic = true })
hl("@variable.parameter",  { fg = "#d8c4ff" })
hl("@property",            { fg = "#b4a7f5" })
hl("@constructor",         { fg = c.yellow })
hl("@function.builtin",    { fg = c.blue, italic = true })
hl("@tag",                 { fg = c.purple })
hl("@tag.attribute",       { fg = c.blue, italic = true })
hl("@tag.delimiter",       { fg = "#96a7dc" })
hl("@string.special.url",  { fg = c.teal, underline = true })
hl("@markup.heading",      { fg = c.purple, bold = true })
hl("@markup.strong",       { bold = true })
hl("@markup.italic",       { italic = true })
hl("@markup.raw",          { fg = c.teal })
hl("@markup.link.url",     { fg = c.blue, underline = true })
hl("@markup.list",         { fg = c.pink })

-- Diagnostic (dipakai LSP di tahap berikutnya)
hl("DiagnosticError", { fg = c.red })
hl("DiagnosticWarn",  { fg = c.yellow })
hl("DiagnosticInfo",  { fg = c.blue })
hl("DiagnosticHint",  { fg = c.teal })
hl("DiagnosticOk",    { fg = c.teal })
hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hl("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yellow })
hl("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.blue })
hl("DiagnosticUnderlineHint",  { undercurl = true, sp = c.teal })

-- Diff (dipakai Git di tahap berikutnya)
hl("DiffAdd",    { bg = "#103a44" })
hl("DiffChange", { bg = "#222f6a" })
hl("DiffDelete", { fg = c.red, bg = "#3d1a2a" })
hl("DiffText",   { bg = "#2b3a8c" })
hl("Added",      { fg = c.teal })
hl("Changed",    { fg = c.yellow })
hl("Removed",    { fg = c.red })
