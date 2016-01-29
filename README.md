lua-getenv
=======

environment variables retrieval module.


## Installation

```
luarocks install getenv --from=http://mah0x211.github.io/rocks/
```


## API

### getenv.sys

Get the system environment variables.

- **Syntax**: `env = getenv.sys()`
- **Returns**
    - `env:table`


### getenv.file

Get the environment variables from file that declared by environment.

**NOTE: file content must be lua script**

- **Syntax**: `env = getenv.file( envname [, dir [, ext]] )`
- **Parameters**: 
    - `envname:string`: environment variable name
    - `dir:string`: target directory (default: `.`)
    - `ext:string`: file extension (default: `.lua`)
- **Returns**
    - `env:table`

