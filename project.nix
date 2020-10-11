{ system ? builtins.currentSystem
}:
let 
  reflexPlatformSrc = builtins.fetchGit { 
    url = "https://github.com/reflex-frp/reflex-platform.git";
    # Note that reflex-platform is pinned to [PR #666] which is the release
    # condidate for the next version.
    # [PR #666]: https://github.com/reflex-frp/reflex-platform/pull/666
    ref = "rc/0.6.0.0";
    rev = "b14992ae74cac755f0e972569434c71ad35489eb";
  };
  reflexPlatform = import reflexPlatformSrc { 
    inherit system;
  };
  project = reflexPlatform.project ({pkgs, ...}: {
    useWarp = true;
    withHoogle = false;
    packages = {
      reflex-stone = ./.;
    };
    shells = {
      ghc = ["reflex-stone"];
      ghcjs = ["reflex-stone"];
    };
  });
in {
  inherit project reflexPlatform;
}
