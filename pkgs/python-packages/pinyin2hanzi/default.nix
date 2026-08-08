{
  lib,
  sources,
  buildPythonPackage,
  setuptools,
}:
buildPythonPackage rec {
  pname = "Pinyin2Hanzi";
  inherit (sources.pinyin2hanzi) version src;
  pyproject = false;

  build-system = [ setuptools ];

  pythonImportsCheck = [ "Pinyin2Hanzi" ];

  meta = {
    description = "Pinyin to Chinese character conversion engine";
    homepage = "https://github.com/someus/Pinyin2Hanzi";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
