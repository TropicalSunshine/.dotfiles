{ pkgs, ... }:
{
    imports = [
        ../dotfiles/common.nix
    ];

    programs.home-manager.enable = true;
    home = {
        username = "jliu";
        homeDirectory = "/Users/jliu";
        packages = with pkgs; [
            roboto
            roboto-mono
            noto-fonts-emoji
        ];
    };

    nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
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
}