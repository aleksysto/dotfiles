return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		-- optional picker via telescope
		{ "nvim-telescope/telescope.nvim" },
		-- optional picker via fzf-lua
		{ "ibhagwan/fzf-lua" },
		-- .. or via snacks
	},
	event = "LspAttach",
	opts = {
		backend = "delta",
	},
}
