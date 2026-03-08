{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixpkgs-fmt
    gnumake
    nixfmt
    clang
  ];
}
