lua-getenv
=======

[![test](https://github.com/mah0x211/lua-getenv/actions/workflows/test.yml/badge.svg)](https://github.com/mah0x211/lua-getenv/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/mah0x211/lua-getenv/badge.svg?branch=master)](https://coveralls.io/github/mah0x211/lua-getenv?branch=master)

environment variables retrieval module.


## Installation

```
luarocks install getenv
```

## env, err = getenv( [name [, filename]] )

get all environment variables or an environment variable with specified name.

**Parameters**

- `name:string`: name of the environment variable.
- `filename:string`: get the environment variables from specified file.

**Returns**

- `env:string|table<string, string>`: a string, or key-value pairs of the environment variables.
- `err:string`: error message.

**NOTE**

the contents of the file must be written as a Lua script like the following;

```lua
FOO='BAR'
HELLO='WORLD'
```

the above global variables are treated as the environment variables.

