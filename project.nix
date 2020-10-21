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
    rev = "8d421e9e06b0477cbc065346aaf596c9db6cc387";
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
