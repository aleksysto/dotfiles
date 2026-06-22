return {
	"forest-nvim/maple.nvim",
	config = function()
		require("maple").setup({
			-- Appearance
			width = 0.75, -- Width of the popup (ratio of the editor width)
			height = 0.75, -- Height of the popup (ratio of the editor height)
			border = "double", -- Border style ('none', 'single', 'double', 'rounded', etc.)
			title = "Project notes:",
			title_pos = "center",
			winblend = 5, -- Window transparency (0-100)
			show_legend = false, -- Whether to show keybind legend in the UI

			-- Storage
			storage_path = vim.fn.stdpath("data") .. "/maple",

			-- Notes management
			notes_mode = "project", -- "global" or "project"
			use_project_specific_notes = true, -- Store notes by project

			-- Keymaps (set to nil to disable)
		})
		vim.keymap.set("n", "<leader>mt", "<cmd>MapleToggle<CR>", { desc = "Toggle Maple Notes" })
		vim.keymap.set("n", "<leader>ms", "<cmd>MapleSwitchMode<CR>", { desc = "Switch notes mode" })
		vim.keymap.set("n", "<leader>mc", "<cmd>MapleToggleCheckbox<CR>", { desc = "Toggle checkbox" })
		vim.keymap.set("n", "<leader>ma", "<cmd>MapleAddCheckbox<CR>", { desc = "Add checkbox" })
		vim.keymap.set("n", "<leader>mf", "<cmd>MapleSearch<CR>", { desc = "Search notes" })
		vim.keymap.set("n", "<leader>mg", "<cmd>MapleSearch grep<CR>", { desc = "Grep notes" })
	end,
}
