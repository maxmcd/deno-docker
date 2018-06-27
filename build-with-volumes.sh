set -e
IMAGE=maxmcd/deno:deno2

./run-and-commit.sh $IMAGE gclient sync --no-history
./run-and-commit.sh $IMAGE gn gen out/Default --args='is_debug=false use_allocator="none" cc_wrapper="ccache" use_custom_libcxx=false use_sysroot=false'
./run-and-commit.sh $IMAGE ninja -C out/Default/ mock_runtime_test deno
./run-and-commit.sh $IMAGE ninja -C out/Default/ deno_rs
