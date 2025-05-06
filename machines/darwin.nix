{ pkgs, ... }:
{
    imports = [
        ../dotfiles/common.nix
    ];

    programs.home-manager.enable = true;
    home = {
        username = "jliu";
        homeDirectory = "/Users/jliu";
    };
}