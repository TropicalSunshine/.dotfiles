{ pkgs, lib, config, ... }:
{
  imports = [
    ./nvim
    ./languages/python3.nix
    ./languages/go.nix
    ./languages/rust.nix
    ./languages/cpp.nix
    ../options/nix.nix
    ../envs/node.nix
  ];

  programs.home-manager.enable = true;

  programs.git = {
      enable = true;
  };

  programs.bash = {
    enable = true;
    shellAliases = {} // lib.optionalAttrs config.programs.git.enable {
      ga = "git add -A";
      gc = "git commit -m";
      gp = "git push origin $(git branch --show-current)";
      gpo = "git pull origin $(git branch --show-current)";
      gcnv = "git commit --no-verify -m";
      gacp = "ga && gc 'update' && gp";
    };
    bashrcExtra = ''
    PS1="\\w:\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\$ "
    source ~/.oldbashrc
    '';
  };


  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./nvim/.vimrc;
  };


  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Roboto" ];
        sansSerif = [ "Roboto" ];
        monospace = [ "Roboto Mono" ];
        emoji = [ "Noto Color Emoji" "Noto Emoji" ];
      };
    };
  };

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
    git-lfs
  ];
}
