return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics_cus toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>xs",
			"<cmd>Trouble lsp_cus toggle<cr>",
			desc = "Symbols (Trouble)",
		},
	},
	config = function()
		require("trouble").setup({
			auto_close = false, -- auto close when there are no items
			auto_open = false, -- auto open when there are items
			auto_preview = false, -- automatically open preview when on an item
			auto_refresh = true, -- auto refresh when open
			auto_jump = false, -- auto jump to the item when there's only one
			focus = true, -- Focus the window when opened
			restore = true, -- restores the last location in the list when opening
			follow = true, -- Follow the current item
			indent_guides = true, -- show indent guides
			max_items = 200, -- limit number of items that can be displayed per section
			multiline = true, -- render multi-line messages
			pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
			warn_no_results = true, -- show a warning when there are no results
			open_no_results = false, -- open the trouble window when there are no results
			keys = {
				["?"] = "help",
				r = "refresh",
				R = "toggle_refresh",
				q = "close",
				o = "jump_close",
				["<esc>"] = "cancel",
				["<cr>"] = "jump",
				["<2-leftmouse>"] = "jump",
				["<c-s>"] = "jump_split",
				["<c-v>"] = "jump_vsplit",
				-- go down to next item (accepts count)
				-- j = "next",
				["}"] = "next",
				["]]"] = "next",
				-- go up to prev item (accepts count)
				-- k = "prev",
				["{"] = "prev",
				["[["] = "prev",
				dd = "delete",
				d = { action = "delete", mode = "v" },
				i = "inspect",
				p = "preview",
				P = "toggle_preview",
				zo = "fold_open",
				zO = "fold_open_recursive",
				zc = "fold_close",
				zC = "fold_close_recursive",
				zz = "fold_toggle",
				zZ = "fold_toggle_recursive",
				zm = "fold_more",
				zM = "fold_close_all",
				zr = "fold_reduce",
				zR = "fold_open_all",
				zx = "fold_update",
				zX = "fold_update_all",
				zn = "fold_disable",
				zN = "fold_enable",
				zi = "fold_toggle_enable",
				zv = {
					-- Toggle "hide Variables" filter in the Symbols view
					action = function(view)
						local f = view:get_filter("no_vars")
						-- if the filter is active, remove it; else, apply it
						view:filter(f and {} or { ["not"] = { kind = { "Variable" } } }, {
							id = "no_vars",
							template = "{hl:Title}Filter:{hl} no Variables",
							del = f ~= nil,
						})
					end,
					desc = "Toggle: hide Variable symbols",
				},
			},
			preview = {
				type = "float",
				-- when a buffer is not yet loaded, the preview window will be created
				-- in a scratch buffer with only syntax highlighting enabled.
				-- Set to false, if you want the preview to always be a real loaded buffer.
				focusable = true,
				scratch = false,
				border = "rounded",
				relative = "editor",
				size = {
					width = 0.5,
					height = 0.4,
				},
				title = "Preview",
				title_pos = "center",
				position = {
					-1,
					-2,
				},
			},
			throttle = {
				refresh = 20, -- fetches new data when needed
				update = 10, -- updates the window
				render = 10, -- renders the window
				follow = 100, -- follows the current item
				preview = { ms = 100, debounce = true }, -- shows the preview for the current item
			},
			modes = {
				-- sources define their own modes, which you can use directly,
				-- or override like in the example below
				diagnostics_cus = {
					mode = "diagnostics", -- inherit from diagnostics mode
					focus = true,
					win = { position = "left", size = 0.25 },
					filter = {
						buf = 0, -- current buffer
					},
				},
				lsp_cus = {
					mode = "lsp_document_symbols", -- inherit from diagnostics mode
					focus = true,
					win = { position = "left", size = 0.25 },
					filter = {
						buf = 0, -- current buffer
					},
				},
			},
		})
	end,
}
