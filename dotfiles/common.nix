{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./nvim
  ];

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