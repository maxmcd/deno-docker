curl --silent "https://api.github.com/repos/denoland/deno/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
