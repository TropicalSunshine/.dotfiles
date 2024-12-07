local nvimTreeApi = require("nvim-tree.api")
local telescopeBuiltins = require("telescope.builtin")

local function toggle_nvimtree_focus()
  if vim.fn.bufname():match('NvimTree_') then
    -- If Nvim Tree is focused, switch back to the previous window
    vim.cmd('wincmd p')
  else
    -- Otherwise, focus on the current file in Nvim Tree
    nvimTreeApi.tree.focus()
  end
end

vim.keymap.set('n', '<S-t>', toggle_nvimtree_focus, { silent = true, desc = "toggle nvim-tree", noremap = true })
vim.keymap.set('n', '<leader>ff', telescopeBuiltins.find_files, {})
