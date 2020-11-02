let 
  p = import ./project.nix { useWarp = false; };
in 
  p.project.ghc.reflex-stone
