{
  lib,
  sources,
  buildPythonPackage,
  rustPlatform,
  cargo,
}:
buildPythonPackage rec {
  pname = "zhconv-rs";
  inherit (sources."zhconv-rs") version src;
  pyproject = true;

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit pname version src;
    hash = lib.fakeHash;
    nativeBuildInputs = [ cargo ];
    postPatch = ''
      cargo generate-lockfile
    '';
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    rustPlatform.maturinBuildHook
  ];

  maturinBuildFlags = [ "-m" "pyo3/Cargo.toml" ];

  env.PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";

  postPatch = ''
    cp README.md pyo3/README.md
  '';

  pythonImportsCheck = [ "zhconv_rs" ];

  meta = {
    description = "Fast Chinese variant conversion backed by Rust";
    homepage = "https://github.com/Gowee/zhconv-rs";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.unix;
  };
}
