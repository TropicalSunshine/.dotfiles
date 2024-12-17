local builtin = require('telescope.builtin')
-- grep git
vim.keymap.set('n', '<leader>gg', builtin.git_files, { desc = 'Telescope find git files' })
-- grep string
vim.keymap.set('n', '<leader>gs', function() 
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
