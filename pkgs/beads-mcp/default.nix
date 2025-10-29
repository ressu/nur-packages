{ lib, pkgs, buildPythonPackage, hatchling, fastmcp, pydantic, pydantic-settings, beads }:

buildPythonPackage rec {
  pname = "beads-mcp";
  version = beads.version;
  format = "pyproject";

  src = beads.src;

  sourceRoot = "source/integrations/beads-mcp";

  postPatch = ''
    sed -i 's/"fastmcp[^"]*"/"fastmcp"/' pyproject.toml
    sed -i 's/"pydantic[^"]*"/"pydantic"/' pyproject.toml
  '';

  nativeBuildInputs = [
    hatchling
  ];

  propagatedBuildInputs = [
    fastmcp
    pydantic
    pydantic-settings
    beads
  ];

  pythonImportsCheck = [ "beads_mcp" ];

  meta = with lib; {
    description = "MCP server for beads issue tracker.";
    homepage = "https://github.com/steveyegge/beads";
        license = licenses.mit;
        broken = lib.versionOlder pkgs.lib.version "25.05";
      };
}
