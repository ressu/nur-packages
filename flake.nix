{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      legacyPackages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (self: super: {
                lib = super.lib.extend (libself: libsuper: {
                  maintainers = libsuper.maintainers // (import ./lib/maintainers.nix);
                });
              })
            ];
          };
        in
        import ./default.nix { inherit pkgs; }
      );
      packages = forAllSystems (system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system});

      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              (self: super: {
                lib = super.lib.extend (libself: libsuper: {
                  maintainers = libsuper.maintainers // (import ./lib/maintainers.nix);
                });
              })
            ];
          };
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              self.legacyPackages.${system}.beads
              self.legacyPackages.${system}.beads-mcp
            ];
          };
        }
      );
    };
}
