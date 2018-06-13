# Deno Docker

Docker images for [ry/deno](https://github.com/ry/deno)

This repo has two images `master` and `slim`. `master` builds deno from scratch and is hopefully a good reference for building deno yourself. `slim` copies the resulting deno executable from `master` if you would like to use it as a standalone executable.

### Deno2

There is now a working deno2 build. As of 13 June 2018 deno2 can't dynamically run code, it simply runs the file `ry/deno/deno2/js/main.ts`. The `deno2` image tag is available to pull for development.
