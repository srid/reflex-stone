{ system ? builtins.currentSystem
}:
let 
  name = "reflex-stone";
  sources = import ./nix/sources.nix;
  rp = import sources.reflex-platform { 
    inherit system;
  };
  project = import ./default.nix { inherit system; };
  app = rp.nixpkgs.lib.getAttr name project.ghcjs;
  wwwDir = ./www;
in 
  rp.nixpkgs.runCommand "${name}-site" {} ''
    mkdir -p $out
    cp ${wwwDir}/index.html $out/
    cp ${app}/bin/${name}.jsexe/all.js $out/
  ''
