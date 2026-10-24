-- =========================================================
-- PERINTAH PROYEK LEARN-JP
--
--   :NewPage <path/to/file.php>
--     Buat halaman PHP baru dengan template lengkap.
--     - Deteksi root proyek otomatis (folder dengan config.php)
--     - Hitung ../ sesuai kedalaman (page/kana/ -> ../../, page/ -> ../)
--     - Prompt 5 metadata dengan default dari nama file
--     - Buka buffer, belum di-write (review dulu sebelum :w)
--
--   :NewPage page/kana/hiragana-chart.php
--   :NewPage milestone/hiragana-m3.php
-- =========================================================
local M = {}

local function find_project_root()
	local function search(start)
		local cur = start
		while cur ~= "/" and cur ~= "" do
			if vim.fn.filereadable(cur .. "/config.php") == 1 then
				return cur
			end
			local parent = vim.fn.fnamemodify(cur, ":h")
			if parent == cur then
				return nil
			end
			cur = parent
		end
		return nil
	end

	-- 1) cwd, lalu 2) folder file buffer aktif (handle `nvim path/file.php`)
	local root = search(vim.fn.getcwd())
	if root then
		return root
	end
	local buf_path = vim.api.nvim_buf_get_name(0)
	if buf_path ~= "" then
		return search(vim.fn.fnamemodify(buf_path, ":h"))
	end
	return nil
end

local function up_prefix(file_dir, root)
	local rel = file_dir:gsub("^" .. vim.pesc(root) .. "/?", "")
	if rel == "" then
		return ""
	end
	local count = 0
	for _ in rel:gmatch("[^/]+") do
		count = count + 1
	end
	return string.rep("../", count)
end

local function title_from(basename)
	local words = {}
	for w in basename:gmatch("[^-]+") do
		table.insert(words, w:sub(1, 1):upper() .. w:sub(2))
	end
	return table.concat(words, " ") .. " - Learn Japanese"
end

local function heading_from(basename)
	return (basename:gsub("-", " "):upper())
end

local function esc(s)
	return (s:gsub('"', '\\"'))
end

local function ask(prompt, default)
	local result = vim.fn.input(prompt .. " [" .. default .. "]: ")
	return result ~= "" and result or default
end

local function new_page(file)
	if file == nil or file == "" then
		vim.notify("Usage: :NewPage <path/to/file.php>", vim.log.levels.ERROR)
		return
	end
	if not file:match("%.php$") then
		file = file .. ".php"
	end

	local root = find_project_root()
	if not root then
		vim.notify(
			"config.php tidak ditemukan di parent mana pun.\nBuka proyek learn-jp dulu (:cd).",
			vim.log.levels.ERROR
		)
		return
	end

	local abs = vim.fn.fnamemodify(file, ":p")
	local dir = vim.fn.fnamemodify(abs, ":h")

	if vim.fn.filereadable(abs) == 1 then
		vim.notify("File sudah ada: " .. file, vim.log.levels.WARN)
		return
	end

	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end

	local up = up_prefix(dir, root)
	local basename = vim.fn.fnamemodify(file, ":t:r")

	local page_title = ask("Title", title_from(basename))
	local page_heading = ask("Heading", heading_from(basename))
	local page_subtitle = vim.fn.input("Subtitle (optional): ")
	local page_description = vim.fn.input("Description (optional): ")
	local current_page = ask("Nav ID", basename)

	local lines = {
		"<?php",
		"require_once __DIR__ . '/" .. up .. "config.php';",
		"",
		'$page_title       = "' .. esc(page_title) .. '";',
		'$page_heading     = "' .. esc(page_heading) .. '";',
		'$page_subtitle    = "' .. esc(page_subtitle) .. '";',
		'$page_description = "' .. esc(page_description) .. '";',
		'$current_page     = "' .. esc(current_page) .. '";',
		"",
		"include __DIR__ . '/" .. up .. "partials/head.php';",
		"include __DIR__ . '/" .. up .. "partials/header.php';",
		"?>",
		"",
		"<main>",
		'\t<div class="content-stack">',
		"\t\t<!-- TODO: replace with content -->",
		"\t\t<p>Content goes here.</p>",
		"\t</div>",
		"</main>",
		"",
		"<?php include __DIR__ . '/" .. up .. "partials/footer.php'; ?>",
		"",
	}

	vim.cmd("edit " .. vim.fn.fnameescape(abs))
	vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
	vim.bo.filetype = "php"

	vim.notify(
		"Created: "
			.. file
			.. "\nNav ID: "
			.. current_page
			.. "\nNext: tambah <a> di partials/nav.php",
		vim.log.levels.INFO
	)
end

function M.setup()
	vim.api.nvim_create_user_command("NewPage", function(opts)
		new_page(opts.args)
	end, { nargs = "?", complete = "file", desc = "Halaman PHP baru (template learn-jp)" })
end

return M
