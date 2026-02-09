{ pkgs, ... }: {

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # Define a profile named "default"
    profiles.default = {
      userSettings = {
        # Set the color theme to Monokai
        "workbench.colorTheme" = "Monokai";
        # Optional: also enable format-on-save globally in this profile
        "editor.formatOnSave" = true;

        "nixFormatter.path" = "nixfmt-classic";

        # Optional: language server settings if you use nixd
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";

        # disable minimap
        "editor.minimap.enabled" = false;
      };

      # Keybindings for this profile
      keybindings = [
        {
          # Ctrl+N => New file
          key = "ctrl+n";
          command = "workbench.action.files.newUntitledFile";
          when = "editorFocus";
        }
        {
          # Ctrl+M => New folder (in Explorer)
          key = "ctrl+m";
          command = "explorer.newFolder";
          when = "explorerViewletVisible && filesExplorerFocus";
        }
      ];

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one

        golang.go
      ];
    };
  };

  home.packages = with pkgs; [ nixfmt-classic go gopls ];

  programs.bash = { shellAliases = { code = "codium"; }; };
}
