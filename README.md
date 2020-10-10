# reflex-stone

Like [Obelisk](https://github.com/obsidiansystems/obelisk), but for static sites.

**Goal**: be a ready-to-use template repo for writing Reflex apps to be used in statically generated websites (no backend).

## Features

- Quick-feedback driven development cycle using ghcid and ghc
- IDE support (Open VSCode and install the suggested extensions)

## Prerequisites

Unless you enjoy compiling for hours at end, you should use the reflex-platform Nix cache by following the [instructions here][cache].

## Development

Running locally using GHC:

```bash
nix-shell --run 'ghcid -T :main'
```

Build JS using GHCJS:

```bash
nix-build site.nix
open ./result/index.html
```

## Tracking reflex-platform

We use `niv` to track dependencies including reflex-platform. Note that reflex-platform is pinned to [PR #666] which is the release condidate for the next version.

## Credits

Original inspiration is [this blog post](https://vaibhavsagar.com/blog/2019/10/29/getting-along-with-javascript/).

[cache]: https://github.com/obsidiansystems/obelisk#installing-obelisk
[PR #666]: https://github.com/reflex-frp/reflex-platform/pull/666