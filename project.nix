{ system ? builtins.currentSystem
}:
let 
  gitignoreSrc = builtins.fetchTarball {
    url = "https://github.com/hercules-ci/gitignore/archive/c4662e6.tar.gz";
    sha256 = "1npnx0h6bd0d7ql93ka7azhj40zgjp815fw2r6smg8ch9p7mzdlx";
  };
  inherit (import (gitignoreSrc) { }) gitignoreSource;
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
      reflex-stone = pkgs.lib.cleanSource (gitignoreSource ./.);
    };
    shells = {
      ghc = ["reflex-stone"];
      ghcjs = ["reflex-stone"];
    };
  });
in {
  inherit project reflexPlatform;
}
