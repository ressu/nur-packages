{ lib, buildGoModule, fetchFromGitHub, pkgs }:

buildGoModule rec {
  pname = "beads";
  version = "0.9.6";

  src = fetchFromGitHub {
    owner = "steveyegge";
    repo = "beads";
    rev = "v${version}";
    hash = "sha256-QpEezKjhQHjfgBRfHrSSlmqjoeLPWjtfHDOMPEt55fs=";
  };

  vendorHash = "sha256-WvwT48izxMxx9qQmZp/6zwv7hHgTVd9KmOJFm7RWvrI=";

  go = pkgs.go;
  doCheck = false;

  meta = with lib; {
    description = "A memory upgrade for your coding agent";
    homepage = "https://github.com/steveyegge/beads";
    license = licenses.mit;
    maintainers = with maintainers; [ ressu ];
  };
}
