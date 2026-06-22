vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.expandtab = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.undodir = os.getenv("HOME") .. "/vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 150

vim.colorcolumn = "80"
vim.g.mapleader = " "
vim.opt.scrolloff = 10
vim.opt.fillchars = { eob = " " }
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	-- Disable underline, it's very annoying
	underline = false,
	-- Enable virtual text, override spacing to 4
	virtual_text = { spacing = 4 },
	signs = true,
	update_in_insert = true,
	source = true,
})
vim.diagnostic.config({ virtual_text = true })

-- Hover
local border_style = "rounded" -- options: "single", "double", "rounded", "solid", "shadow"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = border_style,
	max_width = 80,
	max_height = 20,
})

-- Signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = border_style,
	max_width = 80,
})

-- Diagnostics float
vim.diagnostic.config({
	float = { border = border_style },
})
vim.api.nvim_create_user_command("TextSurround", function(opt)
	local character = opt.args
	local close_char = opt.args
	local base_open = opt.args:sub(1, 1)
	local pairs = {
		["("] = ")",
		["["] = "]",
		["{"] = "}",
		["<"] = ">",
	}
	local reverse_pairs = {
		[")"] = "(",
		["]"] = "[",
		["}"] = "{",
		[">"] = "<",
	}
	if pairs[base_open] then
		close_char = string.rep(pairs[base_open], #opt.args)
	end
	if reverse_pairs[base_open] then
		character = string.rep(reverse_pairs[base_open], #opt.args)
		close_char = base_open
	end

	local vstart = vim.fn.getpos("v")
	local vend = vim.fn.getcurpos()

	local line_s, col_s = vstart[2], vstart[3]
	local line_e, col_e = vend[2], vend[3]
	if line_s > line_e then
		local placeholder = line_e
		line_e = line_s
		line_s = placeholder

		local placeholder2 = col_e
		col_e = col_s
		col_s = placeholder2
	end
	if (line_s == line_e) and (col_s > col_e) then
		local placeholder3 = col_e
		col_e = col_s
		col_s = placeholder3
	end

	local lines = vim.api.nvim_buf_get_lines(0, line_s - 1, line_e, false)
	local firstline = lines[1]
	local lastline = lines[#lines]
	local modifiedfirstline = firstline:sub(1, col_s - 1) .. character .. firstline:sub(col_s)
	if line_s == line_e then
		col_e = col_e + string.len(character)
		modifiedfirstline = modifiedfirstline:sub(1, col_e)
			.. close_char
			.. firstline:sub(col_e - string.len(character) + 1)
		lines[1] = modifiedfirstline
		vim.api.nvim_buf_set_lines(0, line_s - 1, line_e, false, lines)
		return
	end

	local modifiedlastline = lastline:sub(1, col_e) .. close_char .. lastline:sub(col_e + 1)
	lines[1] = modifiedfirstline
	lines[#lines] = modifiedlastline
	vim.api.nvim_buf_set_lines(0, line_s - 1, line_e, false, lines)
end, { nargs = 1 })

vim.keymap.set("v", "<leader>e", function()
	vim.ui.input({ prompt = "Enter surrounding character(s): " }, function(input)
		if input ~= nil and input ~= "" then
			vim.cmd("TextSurround " .. input)
		end
	end)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
end, {
	noremap = true,
	silent = false,
	desc = "Surround selection with next-char",
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "gsv", function()
			vim.cmd("vsplit")
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "gsh", function()
			vim.cmd("split")
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "gn", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", {})
		vim.keymap.set("n", "gb", "<cmd>tabc | tabp<CR>", {})
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float({ source = true })
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help({ border = "rounded" })
		end, opts)
	end,
})
