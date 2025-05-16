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
        -- telescope
        local map = vim.keymap.set
        map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "telescope live grep" })
        local telescope_builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>pws', function()
          local word = vim.fn.expand("<cword>")
          telescope_builtin.grep_string({ search = word })
        end)
        map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "telescope find buffers" })
        map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "telescope help page" })
        map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "telescope find marks" })
        map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "telescope find oldfiles" })
        map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "telescope find in current buffer" })
        map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "telescope git commits" })
        map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "telescope git status" })
        map("n", "<leader>gf", "<cmd>Telescope git_files<CR>", { desc = "telescope find git files"})
        map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "telescope pick hidden term" })

        map("n", "<leader>th", function()
        require("nvchad.themes").open()
        end, { desc = "telescope nvchad themes" })

        map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
        map(
          "n",
          "<leader>fa",
          "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
          { desc = "telescope find all files" }
        )
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
        '';
      }
    ];
  };
}
