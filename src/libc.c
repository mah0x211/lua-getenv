/**
 *  Copyright (C) 2022 Masatoshi Fukunaga
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a
 *  copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sublicense,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 *  DEALINGS IN THE SOFTWARE.
 */

#include <lua.h>
#include <stdlib.h>
#include <string.h>

extern char **environ;

static int getenv_lua(lua_State *L)
{
    char **ptr = environ;

    lua_newtable(L);
    while (*ptr) {
        char *val = strchr(*ptr, '=');
        if (val) {
            lua_pushlstring(L, *ptr, (ptrdiff_t)val - (ptrdiff_t)*ptr);
            lua_pushstring(L, val + 1);
            lua_rawset(L, -3);
        }
        ptr++;
    }

    return 1;
}

LUALIB_API int luaopen_getenv_libc(lua_State *L)
{
    lua_pushcfunction(L, getenv_lua);
    return 1;
}
