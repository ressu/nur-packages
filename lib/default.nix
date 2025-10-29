{ pkgs }:

with pkgs.lib; let
  our-maintainers = import ./maintainers.nix;
in {
  # Add your library functions here
  #
  # hexint = x: hexvals.${toLower x};

  maintainers = pkgs.lib.maintainers // our-maintainers;
}
