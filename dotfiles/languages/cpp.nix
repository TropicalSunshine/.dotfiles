{ pkgs, ... }: {
  home.packages = with pkgs; [ llvmPackages.clang-unwrapped boost ];

  home.sessionVariables = { LD_LIBRARY_PATH = "${pkgs.boost}/lib:"; };
}
