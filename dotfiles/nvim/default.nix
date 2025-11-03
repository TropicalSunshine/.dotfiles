{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nixd
    tinymist
  ];

  programs.neovim = {
    enable = true;
    extraConfig = builtins.readFile ./.vimrc + ''
      " LSP config (the mappings used in the default file don't quite work right)
      nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
      nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
      nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
      nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
      nnoremap <silent> gl <cmd>lua vim.diagnostic.open_float()<CR>
      nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
      nnoremap <silent> <leader>ln <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
      nnoremap <silent> <leader>lp <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
      nnoremap <silent> <leader>la <cmd>lua vim.lsp.buf.code_action()<CR>
      nnoremap <silent> <leader>lr <cmd>lua vim.lsp.buf.rename()<CR>
      nnoremap <silent> <leader>ls <cmd>lua vim.lsp.buf.signature_help()<CR>
      nnoremap <silent> <leader>lq <cmd>lua vim.diagnostic.setloclist()<CR>
    '';
    extraLuaConfig = ''
      vim.diagnostic.config({
        virtual_text = false,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    '';
    plugins = with pkgs.vimPlugins; [
      {
        plugin = nightfox-nvim;
        type = "lua";
        config = ''
          require('nightfox')
          vim.cmd.colorscheme("nordfox")
        '';
      }
      # utils
      vim-airline
      vim-signify # shows git diff
      rainbow-delimiters-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
          vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope git files' })
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
          vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        '';
      }
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require'nvim-tree'.setup({
            filters = { dotfiles = false },
            disable_netrw = true,
            hijack_cursor = true,
            sync_root_with_cwd = true,
            update_focused_file = {
              enable = true,
              update_root = false,
            },
            view = {
              width = 30,
              preserve_window_proportions = true,
            },
            renderer = {
              root_folder_label = false,
              highlight_git = true,
              indent_markers = { enable = true }
            },
          })

          local map = vim.keymap.set
          map("n", "<S-t>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
          map("n", "<S-f>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
        '';
      }
      {
        plugin = indent-blankline-nvim;
        type = "lua";
        config = ''
          require'ibl'.setup()
        '';
      }
      # cool lsp stuff
      {
        plugin = lsp_lines-nvim;
        type = "lua";
        config = ''
          require'lsp_lines'.setup()
          vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
        '';
      }
      # languages
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup({
            highlight = {
              enable = true,
            },
          })
        '';
      }
      # snippets
      luasnip
      cmp_luasnip
      # completion
      cmp-nvim-lsp # lsp completions
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./cmp.lua;
      }
      # lsp
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          require'lspconfig'.hls.setup{
            cmd = { "haskell-language-server", "--lsp" }
          , capabilities = capabilities
          , settings = {
              haskell = {
                formattingProvider = "fourmolu"
              }
            }
          }
          require'lspconfig'.ocamllsp.setup{
            capabilities = capabilities
          }
          require'lspconfig'.tinymist.setup{
            capabilities = capabilities
          }
          require'lspconfig'.nixd.setup{
            capabilities = capabilities
          }
          require'lspconfig'.rust_analyzer.setup{
            capabilities = capabilities
          , settings = {
              ['rust-analyzer'] = {
                checkOnSave = {
                  command = "clippy"
                },
                diagnostics = {
                  enable = false;
                }
              }
            }
          }
          require'lspconfig'.gopls.setup{
            capabilities = capabilities
          }
        '';
      }
    ];
  };
}
