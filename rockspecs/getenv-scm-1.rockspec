package = "getenv"
version = "scm-1"
source = {
    url = "git+https://github.com/mah0x211/lua-getenv.git"
}
description = {
    summary = "environment variables retrieval module",
    homepage = "https://github.com/mah0x211/lua-getenv",
    license = "MIT/X11",
    maintainer = "Masatoshi Fukunaga"
}
dependencies = {
    "lua >= 5.1",
    "loadchunk >= 0.1.1",
}
build = {
    type = "builtin",
    modules = {
        getenv = "getenv.lua",
        ['getenv.libc'] = {
            sources = { 'src/libc.c' }
        }
    }
}
