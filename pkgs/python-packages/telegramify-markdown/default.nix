{
  lib,
  sources,
  buildPythonPackage,
  pdm-backend,
  pyromark,
}:
buildPythonPackage rec {
  pname = "telegramify-markdown";
  version = lib.removePrefix "pypi_" sources."telegramify-markdown".version;
  inherit (sources."telegramify-markdown") src;
  pyproject = true;

  build-system = [ pdm-backend ];

  dependencies = [ pyromark ];

  pythonImportsCheck = [ "telegramify_markdown" ];

  meta = {
    description = "Convert Markdown to Telegram plain text and entities";
    homepage = "https://github.com/sudoskys/telegramify-markdown";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
  };
}
