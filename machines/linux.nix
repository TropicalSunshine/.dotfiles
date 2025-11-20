
{ pkgs, ... }:
{
    imports = [
        ../dotfiles/common.nix
    ];


    home = {
      username = "jliu";
      homeDirectory = "/home/jliu";
    };

    home.packages = with pkgs; [
      # collection of ip utilities including 'ip'
      iproute2
    ];
}
