{
  lib,
  sources,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage rec {
  pname = "proces";
  inherit (sources.proces) version src;
  pyproject = false;

  build-system = [ setuptools ];

  pythonImportsCheck = [ "proces" ];

  meta = {
    description = "Text preprocess utilities";
    homepage = "https://github.com/Ailln/proces";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
