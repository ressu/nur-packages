{ lib, buildGoModule, fetchFromGitHub, pkgs }:

buildGoModule rec {
  pname = "beads";
  version = "0.17.7";

  src = fetchFromGitHub {
    owner = "steveyegge";
    repo = "beads";
    rev = "v${version}";
    hash = "sha256-eX1dmJmQKdSwvWGJBA1S0cOi5p9cR2Z9d+DQhysAryk=";
  };

  vendorHash = "sha256-DJqTiLGLZNGhHXag50gHFXTVXCBdj8ytbYbPL3QAq8M=";

  go = pkgs.go;
  doCheck = false;

  meta = with lib; {
    description = "A memory upgrade for your coding agent";
    homepage = "https://github.com/steveyegge/beads";
    license = licenses.mit;

  };
}
