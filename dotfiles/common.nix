{ pkgs, ... }:
{
  imports = [
    ./nvim
    ./languages/python3.nix
    ./languages/go.nix
    ./languages/rust.nix
    ./languages/cpp.nix
    ../options/nix.nix
  ];

  programs.home-manager.enable = true;


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
