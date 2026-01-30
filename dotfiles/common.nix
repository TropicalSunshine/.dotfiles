{ pkgs, lib, config, ... }: {
  imports = [ ./nvim ./languages/python3.nix ./vscode.nix ../options/nix.nix ];

  programs.home-manager.enable = true;

  programs.git = { enable = true; };

  programs.readline = { enable = true; };

  programs.tmux = { enable = true; };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = builtins.readFile ./bashrc.sh;
    shellAliases = {
      lsa = "ls -a --color=auto";
    } // lib.optionalAttrs config.programs.git.enable {
      ga = "git add -A";
      gc = "git commit -m";
      gp = "git push origin $(git branch --show-current)";
      gpo = "git pull origin $(git branch --show-current)";
      gcnv = "git commit --no-verify -m";
      gacp = "ga && gc 'update' && gp";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "Consolas";
      size = 12;
    };

    shellIntegration = {
      mode = "enabled";
      enableBashIntegration = true;
    };
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./nvim/.vimrc;
  };

  fonts = { fontconfig = { enable = true; }; };

  home.packages = with pkgs; [
    curl
    jq
    unzip
    zip
    roboto
    roboto-mono
    noto-fonts-emoji
    tmux
    xclip
    direnv

    #fonts
    nerd-fonts.jetbrains-mono
  ];
}
