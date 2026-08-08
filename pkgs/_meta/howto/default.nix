{
  writeTextFile,
  lib,
}:
writeTextFile rec {
  name = "00000-howto";
  text = ''
    Use this repository as a flake input or overlay:

    {
      inputs.zhyi-packages.url = "github:zhyiheihei/zhyi-packages";
    }

    Binary cache settings will be added to helpers/meta.nix once one is available.
  '';
  meta = {
    maintainers = [
      {
        github = "zhyiheihei";
        name = "zhyiheihei";
      }
    ];
    description = text;
    homepage = "https://github.com/zhyiheihei/zhyi-packages";
    license = lib.licenses.unlicense;
  };
}
