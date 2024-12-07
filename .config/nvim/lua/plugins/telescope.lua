local actions = require("telescope.actions")

require("telescope").setup{
	  defaults = {
		  layout_strategy = "vertical",
		  layout_config = { height = 0.75 },
		  mappings = {
		    i = {
		      ["<esc>"] = actions.close,
		      ["<C-o>"] = actions.send_selected_to_qflist
		    }
		  },
		  scroll_strategy = "limit",
		  vimgrep_arguments = {
		    'rg',
		    '--color=never',
		    '--no-heading',
		    '--with-filename',
		    '--line-number',
		    '--column',
		    '--smart-case',
		    '--hidden' -- ADDED OVER ABOVE DEFAULTS (https://github.com/nvim-telescope/telescope.nvim/blob/301505da4bb72d11ffeee47ad45e0b677f70abe5/doc/telescope.txt#L540-L557)
		  },
	},
	pickers = {
		find_file = {
			hidden = true
		}
	},
        extensions = { heading = { treesitter = true } }
}
