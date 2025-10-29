# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ nixpkgs ? import <nixpkgs> { } }:

let
  pkgs = nixpkgs.extend (self: super: {
    lib = super.lib.extend (libself: libsuper: {
      maintainers = libsuper.maintainers // (import ./lib/maintainers.nix);
    });
  });
in
rec {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { pkgs = pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  example-package = pkgs.callPackage ./pkgs/example-package { };
  beads = pkgs.callPackage ./pkgs/beads { };
  beads-mcp = pkgs.python3Packages.callPackage ./pkgs/beads-mcp {
    inherit beads;
  };

  # some-qt5-package = pkgs.libsForQt5.callPackage ./pkgs/some-qt5-package { };
  # ...
}
