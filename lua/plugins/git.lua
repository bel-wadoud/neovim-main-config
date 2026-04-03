-- git.lua
return {
	-- Git signs in the gutter
	{
		"lewis6991/gitsigns.nvim",
		lazy = false, -- load at startup
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				signs = {
					add = { hl = "GitGutterAdd", text = "▎", numhl = "GitGutterAddNr" },
					change = { hl = "GitGutterChange", text = "▎", numhl = "GitGutterChangeNr" },
					delete = { hl = "GitGutterDelete", text = "▎", numhl = "GitGutterDeleteNr" },
					topdelete = { hl = "GitGutterDeleteChange", text = "▔", numhl = "GitGutterDeleteChangeNr" },
					changedelete = { hl = "GitGutterChange", text = "▎", numhl = "GitGutterChangeNr" },
				},
				numhl = true,
				linehl = false,
				watch_gitdir = { interval = 1000 },
				current_line_blame = true, -- show git blame
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 500,
				},
			})

			-- Keymaps for Git hunks
			local map = vim.keymap.set
			map("n", "]h", gitsigns.next_hunk, { desc = "Next Git hunk" })
			map("n", "[h", gitsigns.prev_hunk, { desc = "Previous Git hunk" })
			map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
			map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })
			map("v", "<leader>hs", function() gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
				{ desc = "Stage hunk visual" })
			map("v", "<leader>hr", function() gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
				{ desc = "Reset hunk visual" })
			map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
			map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
			map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
			map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
			map("n", "<leader>hb", function() gitsigns.blame_line { full = true } end, { desc = "Blame line" })
			map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this file" })
			map("n", "<leader>hD", function() gitsigns.diffthis("~") end, { desc = "Diff vs HEAD~" })
		end,
	},

	-- Telescope Git pickers
	{
		"nvim-telescope/telescope.nvim",
		lazy = false,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = { sorting_strategy = "ascending", layout_strategy = "horizontal" },
				pickers = {
					git_files = { show_untracked = true },
					git_commits = { show_line = true },
				},
			})

			-- Keymaps for Telescope Git
			local map = vim.keymap.set
			map("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "Git files" })
			map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "Git commits" })
			map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "Git branches" })
			map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "Git status" })
		end,
	},
}
