-- =========================================================
-- KLIEN REST MINI (berbasis curl, tanpa plugin)
--
-- Tulis permintaan di file .http / .rest, jalankan dengan <leader>rr.
--
--     @host = https://httpbin.org
--     @token = rahasia
--
--     ### Ambil data
--     GET {{host}}/get?x=1
--     Accept: application/json
--     Authorization: Bearer {{token}}
--
--     ### Kirim data
--     POST {{host}}/post
--     Content-Type: application/json
--
--     {"nama": "palu", "stok": 3}
--
-- Aturan: blok dipisah baris "###"; baris "@nama = nilai" mendefinisikan variabel
-- (dipakai sebagai {{nama}}); baris berawalan # atau // adalah komentar;
-- baris kosong memisahkan header dari body.
--
-- Keymap (di buffer .http):  <leader>rr jalankan | <leader>rc salin sebagai curl
--                            <leader>rH tampilkan header respons
-- =========================================================
local M = {}

local RESPONSE_NAME = "[REST response]"

local function collect_vars(lines)
	local vars = {}
	for _, l in ipairs(lines) do
		local k, v = l:match("^@([%w_%-%.]+)%s*=%s*(.-)%s*$")
		if k then
			vars[k] = v
		end
	end
	return vars
end

local function substitute(text, vars)
	local missing = {}
	local out = text:gsub("{{%s*([%w_%-%.]+)%s*}}", function(name)
		if vars[name] ~= nil then
			return vars[name]
		end
		table.insert(missing, name)
		return "{{" .. name .. "}}"
	end)
	return out, missing
end

local function block_range(lines, cursor)
	local s, e = 1, #lines
	for i = cursor, 1, -1 do
		if lines[i]:match("^###") then
			s = i + 1
			break
		end
	end
	for i = cursor + 1, #lines do
		if lines[i]:match("^###") then
			e = i - 1
			break
		end
	end
	return s, e
end

function M.parse(lines, cursor)
	local vars = collect_vars(lines)
	local s, e = block_range(lines, cursor)

	local i = s
	while
		i <= e
		and (
			lines[i]:match("^%s*$")
			or lines[i]:match("^%s*#")
			or lines[i]:match("^%s*//")
			or lines[i]:match("^@")
		)
	do
		i = i + 1
	end
	if i > e then
		return nil, "Tidak ada permintaan di blok ini"
	end

	local method, url = lines[i]:match("^(%u+)%s+(%S+)")
	if not method then
		return nil, "Baris permintaan tidak valid (contoh: GET https://contoh.com): " .. lines[i]
	end

	local headers, body_lines = {}, {}
	i = i + 1
	-- Parse header sampai baris kosong ATAU baris yang bukan header (awal body)
	while i <= e do
		local l = lines[i]
		if l:match("^%s*$") then
			break
		elseif l:match("^%s*#") or l:match("^%s*//") then
			i = i + 1
		else
			local name, value = l:match("^([%w%-_]+)%s*:%s*(.-)%s*$")
			if name then
				table.insert(headers, name .. ": " .. value)
				i = i + 1
			else
				break -- bukan header: mulai body di sini
			end
		end
	end
	-- Lewati baris kosong pemisah
	while i <= e and lines[i]:match("^%s*$") do
		i = i + 1
	end
	-- Sisa baris = body (termasuk bila tidak ada baris kosong pemisah)
	for j = i, e do
		table.insert(body_lines, lines[j])
	end
	while #body_lines > 0 and body_lines[#body_lines]:match("^%s*$") do
		table.remove(body_lines)
	end

	local missing_all = {}
	local function sub(text)
		local out, missing = substitute(text, vars)
		vim.list_extend(missing_all, missing)
		return out
	end

	local req = { method = method, url = sub(url), headers = {}, body = nil }
	for _, h in ipairs(headers) do
		table.insert(req.headers, sub(h))
	end
	if #body_lines > 0 then
		req.body = sub(table.concat(body_lines, "\n"))
	end
	req.missing = missing_all
	return req
end

function M.curl_args(req)
	local args = { "curl", "-sS", "-i", "--max-time", "30", "-X", req.method }
	for _, h in ipairs(req.headers) do
		vim.list_extend(args, { "-H", h })
	end
	if req.body then
		vim.list_extend(args, { "--data-binary", "@-" })
	end
	vim.list_extend(args, { "-w", "\n__REST_TIME__%{time_total}", req.url })
	return args
end

function M.split_response(raw)
	local time = raw:match("__REST_TIME__([%d%.]+)%s*$")
	raw = raw:gsub("\n__REST_TIME__[%d%.]+%s*$", "")
	local head, body = raw, ""
	while true do
		local h, b = head:match("^(HTTP/[^\r\n]*.-)\r?\n\r?\n(.*)$")
		if not h then
			break
		end
		head, body = h, b
		if not body:match("^HTTP/%d") then
			break
		end
		head = body
	end
	local status = head:match("^(HTTP/[^\r\n]*)") or "?"
	local headers = {}
	for l in head:gmatch("[^\r\n]+") do
		if not l:match("^HTTP/") then
			table.insert(headers, l)
		end
	end
	return { status = status, headers = headers, body = body, time = tonumber(time) }
end

local function response_window()
	for _, w in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w)):find(RESPONSE_NAME, 1, true) then
			return w
		end
	end
end

local function show_response(res)
	local win = response_window()
	local buf
	if win then
		buf = vim.api.nvim_win_get_buf(win)
	else
		vim.cmd("botright vsplit")
		win = vim.api.nvim_get_current_win()
		buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_win_set_buf(win, buf)
		vim.api.nvim_buf_set_name(buf, RESPONSE_NAME)
		vim.bo[buf].bufhidden = "wipe"
		vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = buf, silent = true })
	end

	local body = res.body
	local ctype = ""
	for _, h in ipairs(res.headers) do
		local v = h:match("^[Cc]ontent%-[Tt]ype:%s*(.-)%s*$")
		if v then
			ctype = v:lower()
		end
	end
	local ft = "text"
	if ctype:find("json", 1, true) then
		ft = "json"
		if vim.fn.executable("jq") == 1 then
			local formatted = vim.fn.system({ "jq", "." }, body)
			if vim.v.shell_error == 0 then
				body = formatted
			end
		end
	elseif ctype:find("html", 1, true) then
		ft = "html"
	elseif ctype:find("xml", 1, true) then
		ft = "xml"
	end

	vim.bo[buf].modifiable = true
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(body, "\r?\n"))
	vim.bo[buf].modifiable = false
	vim.bo[buf].filetype = ft
	vim.b[buf].rest_headers = res.headers
	vim.wo[win].wrap = true
	vim.wo[win].winbar = string.format(
		" %s  ·  %s s  ·  %s",
		res.status,
		res.time and string.format("%.3f", res.time) or "?",
		ctype ~= "" and ctype or "tanpa content-type"
	)
	vim.api.nvim_set_current_win(win)
	vim.api.nvim_win_set_cursor(win, { 1, 0 })
	vim.cmd("wincmd p")
end

function M.run(callback)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local req, err = M.parse(lines, vim.api.nvim_win_get_cursor(0)[1])
	if not req then
		vim.notify(err, vim.log.levels.WARN)
		return
	end
	if #req.missing > 0 then
		vim.notify(
			"Variabel belum didefinisikan: " .. table.concat(req.missing, ", "),
			vim.log.levels.WARN
		)
	end
	if vim.fn.executable("curl") ~= 1 then
		vim.notify("curl tidak ditemukan", vim.log.levels.ERROR)
		return
	end

	vim.notify(req.method .. " " .. req.url .. " ...")
	vim.system(M.curl_args(req), { text = true, stdin = req.body }, function(result)
		vim.schedule(function()
			if result.code ~= 0 then
				vim.notify(
					"curl gagal (" .. result.code .. "): " .. vim.trim(result.stderr or ""),
					vim.log.levels.ERROR
				)
			else
				show_response(M.split_response(result.stdout or ""))
			end
			if callback then
				callback(result)
			end
		end)
	end)
end

function M.copy_curl()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local req, err = M.parse(lines, vim.api.nvim_win_get_cursor(0)[1])
	if not req then
		vim.notify(err, vim.log.levels.WARN)
		return
	end
	local parts = { "curl", "-X", req.method }
	for _, h in ipairs(req.headers) do
		vim.list_extend(parts, { "-H", vim.fn.shellescape(h) })
	end
	if req.body then
		vim.list_extend(parts, { "--data-raw", vim.fn.shellescape(req.body) })
	end
	table.insert(parts, vim.fn.shellescape(req.url))
	local cmd = table.concat(parts, " ")
	pcall(vim.fn.setreg, "+", cmd)
	vim.fn.setreg('"', cmd)
	vim.notify("Disalin sebagai curl")
	return cmd
end

function M.show_headers()
	local win = response_window()
	if not win then
		vim.notify("Belum ada respons", vim.log.levels.INFO)
		return
	end
	local headers = vim.b[vim.api.nvim_win_get_buf(win)].rest_headers or {}
	vim.lsp.util.open_floating_preview(
		headers,
		"http",
		{ border = "rounded", title = " Header respons " }
	)
end

function M.setup()
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("bagus_rest", { clear = true }),
		pattern = "http",
		callback = function(ev)
			local function map(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
			end
			map("<leader>rr", function()
				M.run()
			end, "Jalankan request")
			map("<leader>rc", M.copy_curl, "Salin sebagai curl")
			map("<leader>rH", M.show_headers, "Header respons")
		end,
	})
end

return M
