{
  lib,
  sources,
  buildPythonPackage,
  rustPlatform,
  typing-extensions,
}:
buildPythonPackage rec {
  pname = "pyromark";
  inherit (sources.pyromark) version src;
  pyproject = true;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = lib.fakeHash;
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
  ];

  dependencies = [ typing-extensions ];

  pythonImportsCheck = [ "pyromark" ];

  meta = {
    description = "Blazingly fast Markdown parser";
    homepage = "https://github.com/monosans/pyromark";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
