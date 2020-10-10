{ system ? builtins.currentSystem
}:
let 
  name = "reflex-stone";
  sources = import ./nix/sources.nix;
  rp = import sources.reflex-platform { 
    inherit system;
  };
  project = import ./default.nix { inherit system; };
  pkgs = rp.nixpkgs;
  app = pkgs.lib.getAttr name project.ghcjs;
  wwwDir = ./www;
in 
  pkgs.runCommand "${name}-site" {} ''
    mkdir -p $out
    cp ${wwwDir}/index.html $out/
    # The original all.js is pretty huge; so let's run it by the closure
    # compiler.    
    # cp ${app}/bin/${name}.jsexe/all.js $out/
    ${pkgs.closurecompiler}/bin/closure-compiler \
        --externs=${app}/bin/${name}.jsexe/all.js.externs \
        --jscomp_off=checkVars \
        --js_output_file="$out/all.js" \
        -O ADVANCED \
        -W QUIET \
        ${app}/bin/${name}.jsexe/all.js
  ''
