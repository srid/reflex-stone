# reflex-stone

Like [Obelisk](https://github.com/obsidiansystems/obelisk), but for static sites.

**Goal**: be a ready-to-use template repo for writing Reflex apps to be used in statically generated websites (no backend).

## Features

- Quick-feedback driven development cycle using ghcid and ghc
- IDE support (Open VSCode and install the suggested extensions)
- GitHub Actions CI & GitHub Pages static site deployment ([view site][pages])

[pages]: http://srid.github.io/reflex-stone/

## Prerequisites

Unless you enjoy compiling for hours at end, you should use the reflex-platform Nix cache by following the [instructions here][cache].

## Development

Running locally using GHC and jsaddle-warp:

```bash
nix-shell --run 'ghcid -T :main'
# Or, to run with a custom port
nix-shell --run 'JSADDLE_WARP_PORT=8080 ghcid -T :main'
```

Build JS using GHCJS:

```bash
nix-build
open ./result/index.html
```

## Credits

Initial inspiration came from [this blog post](https://vaibhavsagar.com/blog/2019/10/29/getting-along-with-javascript/).

[cache]: https://github.com/obsidiansystems/obelisk#installing-obelisk
