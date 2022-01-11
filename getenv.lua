--
-- Copyright (C) 2016 Masatoshi Teruya
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
-- getenv.lua
-- lua-getenv
-- Created by Masatoshi Teruya on 16/01/29.
--
local error = error
local process_getenv = require('process').getenv
local loadfile = require('loadchunk').file

--- get the environment variables from file that declared by environment
--- @param filename string
--- @return table<string, string> envs
--- @return string err
local function getenvfile(filename)
    -- check arguments
    if type(filename) ~= 'string' then
        error('filename must be string', 2)
    end

    local env = {}
    local fn, err = loadfile(filename, env)
    if err then
        return nil, err
    end

    -- run
    local ok, perr = pcall(fn)
    if not ok then
        return nil, perr
    end

    return env
end

--- get the system environment variables
--- @vararg
--- @return table<string, string> envs
--- @return string err
local function getenv(...)
    if select('#', ...) > 0 then
        return getenvfile(...)
    end
    return process_getenv()
end

return getenv

