{ pkgs, ... }:
{
    imports = [
        ../dotfiles/common.nix
    ];

    home = {
      username = "jliu";
      homeDirectory = "/Users/jliu";
    };

    home.packages = with pkgs; [
      darwin.iproute2mac
    ];
}
