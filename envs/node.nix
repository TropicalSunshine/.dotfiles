
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
    nodenv
  ];

  home.sessionVariables = {
    LD_LIBRARY_PATH = "${pkgs.boost}/lib:";
  };
}
