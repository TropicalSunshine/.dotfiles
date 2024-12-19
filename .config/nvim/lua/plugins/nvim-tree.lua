-- requires nerd font https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-7-install-script
return {
    "nvim-tree/nvim-tree.lua",

    tag = "v1.9.0",

    dependencies = {
        "nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
    },

	config = function()
		require("nvim-tree").setup()
		-- disable netrw at the very start of your init.lua
		-- for nvim-tree
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.keymap.set('n', '<S-t>', function()
			if vim.fn.bufname():match('NvimTree_') then
				-- If Nvim Tree is focused, switch back to the previous window
				vim.cmd('wincmd p')
			else
				-- Otherwise, focus on the current file in Nvim Tree
				require("nvim-tree.api").tree.focus()
			end
		end)
	end
}

