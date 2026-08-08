{
  lib,
  sources,
  buildPythonPackage,
  setuptools,
  proces,
}:
buildPythonPackage rec {
  pname = "cn2an";
  inherit (sources.cn2an) version src;
  pyproject = false;

  build-system = [ setuptools ];

  dependencies = [ proces ];

  pythonImportsCheck = [ "cn2an" ];

  meta = {
    description = "Convert Chinese numerals and Arabic numerals";
    homepage = "https://github.com/Ailln/cn2an";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
