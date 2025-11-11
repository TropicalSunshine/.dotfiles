
{ pkgs, ... }:
{
    imports = [
        ../dotfiles/common.nix
    ];

    home.packages = with pkgs; [
      # collection of ip utilities including 'ip'
      iproute2
    ];
}
