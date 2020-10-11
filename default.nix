{ system ? builtins.currentSystem
}:
let 
  name = "reflex-stone";
  p = import ./project.nix { inherit system; };
  pkgs = p.reflexPlatform.nixpkgs;
  app = pkgs.lib.getAttr name p.project.ghcjs;
  indexHtml = pkgs.writeText "index.html"
    ''
    <!DOCTYPE html>
    <html>
    <head>
      <script language="javascript" src="all.js"></script>
    </head>
    <body></body>
    </html>
    '';
in 
  pkgs.runCommand "${name}-site" {} ''
    mkdir -p $out
    cp ${indexHtml} $out/index.html
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
