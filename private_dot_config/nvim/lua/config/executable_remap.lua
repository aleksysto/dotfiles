vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- vim.keymap.set("n", "n", "nzzzv")
-- vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>tr", "<cmd>Trouble diags open<CR>")
vim.keymap.set("n", "<leader>ntd", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "<leader>ptd", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
vim.keymap.set("n", "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })
vim.keymap.set("", "<leader>fm", function()
	require("conform").format({ async = true }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end, { desc = "Format code" })

vim.keymap.set("n", "<leader>l", "o<Esc>")
vim.keymap.set("n", "<leader>L", "O<Esc>")
vim.keymap.set("n", "<leader>ww", function()
	local winid = require("window-picker").pick_window()
	if winid then
		vim.api.nvim_set_current_win(winid)
	end
end, { desc = "Pick a window to focus" })
function SwapWindows()
	local win1 = require("window-picker").pick_window()
	local win2 = require("window-picker").pick_window()
	if win1 and win2 then
		local buf1 = vim.api.nvim_win_get_buf(win1)
		local buf2 = vim.api.nvim_win_get_buf(win2)

		vim.api.nvim_win_set_buf(win1, buf2)
		vim.api.nvim_win_set_buf(win2, buf1)
	end
end

vim.api.nvim_set_keymap("n", "<leader>ws", ":lua SwapWindows()<CR>", { noremap = true, silent = true })
