FROM maxmcd/deno:_build-cache

WORKDIR /opt/
RUN git clone https://github.com/ry/deno.git
WORKDIR /opt/deno/src
RUN cd js; yarn install
# RUN gclient sync --no-history
# RUN gn gen out/Default --args='is_debug=false use_allocator="none" cc_wrapper="ccache" use_custom_libcxx=false use_sysroot=false'
# RUN ninja -C out/Default/ mock_runtime_test deno
# RUN ninja -C out/Default/ deno_rs

# CMD /opt/deno/src/out/Default/deno

