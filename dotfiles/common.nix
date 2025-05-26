{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./nvim
    ./languages/python3.nix
    ./languages/go.nix
  ];

  programs.home-manager.enable = true;
  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./nvim/.vimrc;
  };

  home.packages = with pkgs; [
    curl
    jq
    unzip
    zip
    ] ++ lib.optionals (pkgs.stdenv.isDarwin) [
    darwin.iproute2mac
    ] ++ lib.optionals (pkgs.stdenv.isLinux) [
    # collection of ip utilities including 'ip'
    iproute2
  ];
}
