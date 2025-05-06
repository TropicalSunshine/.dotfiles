{ pkgs, config, lib, osConfig, ... }:
{
  imports = [
    ./git.nix
  ];

  home.packages = with pkgs; [
    curl
    jq
    iperf
    # collection of ip utilities including 'ip'
    iproute2
    unzip
    zip
  ];
}