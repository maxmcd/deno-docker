set -e
set -o pipefail

curl "https://api.github.com/repos/denoland/deno/releases/latest?access_token=$GITHUB_TOKEN" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'

