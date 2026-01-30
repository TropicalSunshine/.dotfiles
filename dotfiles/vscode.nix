{ config, pkgs, ... }: {

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
        brettm12345.nixfmt-vscode
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
        bbenoist.nix
      ];
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = builtins.readFile ./bashrc.sh;
    shellAliases = { vscode = "codium"; };
  };

  home.packages = with pkgs; [ nixfmt-classic ];
}
