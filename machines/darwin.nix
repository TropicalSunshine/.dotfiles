{ pkgs, ... }:
{
    imports = [
        ../dotfiles/common.nix
    ];

    home = {
      username = "jliu";
      homeDirectory = "/Users/jliu";
    };
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
      darwin.iproute2mac
    ];
}
