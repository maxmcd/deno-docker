FROM maxmcd/deno:_build-cache

RUN git pull origin master
RUN ./tools/build_third_party.py
RUN gn gen out/Default/ --args='is_debug=false use_allocator="none" cc_wrapper="ccache" use_custom_libcxx=false use_sysroot=false'
RUN ccache -s
RUN ninja -C out/Default/ :all

