--[[

  Copyright (C) 2016 Masatoshi Teruya
 
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
 
  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.
 
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.

  getenv.lua
  lua-getenv
  Created by Masatoshi Teruya on 16/01/29.

--]]
local environ = require('process').getenv();
local evalfile = require('util').evalfile;


--- get the system environment variables
-- @return evn
local function getenvsys()
    local env = {};

    -- copy system environments
    for k, v in pairs( environ ) do
        env[k] = v;
    end

    return env;
end


--- get the environment variables from file that declared by environment
-- @param envname
-- @param dir
-- @param ext
-- @return env
-- @return err
local function getenvfile( envname, dir, ext )
    -- check arguments
    if type( envname ) ~= 'string' then
        error( 'envname must be string', 2 );
    end

    if dir == nil then
        dir = '.';
    elseif type( dir ) ~= 'string' then
        error( 'dir must be string', 2 );
    end

    if ext == nil then
        ext = '.lua';
    elseif type( ext ) ~= 'string' then
        error( 'ext must be string', 2 );
    end

    if environ[envname] then
        local env = {};
        -- load file as lua
        local path = ('%s/%s%s'):format( dir, environ[envname], ext );
        local fn, err = evalfile( path, env );
        local ok;

        if err then
            return nil, err;
        end

        -- run
        ok, err = pcall( fn );
        if err then
            return nil, err;
        end

        return env;
    end
end


return {
    sys = getenvsys,
    file = getenvfile
};

