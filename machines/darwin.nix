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

    programs.bash.bashrcExtra = ''
    export PS1="\\w:\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\$ "
    '';

    home.packages = with pkgs; [
      darwin.iproute2mac
      git
    ];
}
