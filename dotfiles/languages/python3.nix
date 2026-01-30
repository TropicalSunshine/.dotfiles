{ pkgs, ... }: {
  home.packages = with pkgs; [ python311Packages.black python311 ];
}
