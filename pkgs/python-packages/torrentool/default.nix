{
  lib,
  sources,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage rec {
  pname = "torrentool";
  inherit (sources.torrentool) version src;
  pyproject = false;

  build-system = [ setuptools ];

  doCheck = false;

  pythonImportsCheck = [ "torrentool" ];

  meta = {
    description = "Tool to work with torrent files";
    homepage = "https://github.com/idlesign/torrentool";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.unix;
  };
}
