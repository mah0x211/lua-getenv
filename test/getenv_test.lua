require('luacov')
local testcase = require('testcase')
local getenv = require('getenv')

local FILENAME = './testenv.lua'
local FILENAME_INVALID = './testenv_inval.lua'

function testcase.before_all()
    for k, v in pairs({
        [FILENAME] = [[
            FOO='BAR'
            HELLO='WORLD'
        ]],
        [FILENAME_INVALID] = [[
            BAR='BA Z
        ]],
    }) do
        local f = assert(io.open(k, 'w+'))
        assert(f:write(v))
        assert(f:close())
    end

end

function testcase.after_all()
    os.remove(FILENAME)
    os.remove(FILENAME_INVALID)
end

function testcase.getenv()
    -- test that get process environment variables
    local envs = assert(getenv())
    assert.is_table(envs)

    assert(envs.TEST_ENV,
           [[testcase must be run with the TEST_ENV environment variable as shown below;
    TEST_ENV=HELLO testcase ./test/
]])
    assert.equal(envs.TEST_ENV, 'HELLO')
end

function testcase.getenv_with_filename()
    -- test that get environment variables from the file
    local envs = assert(getenv(FILENAME))
    assert.is_table(envs)
    assert.equal(envs, {
        FOO = 'BAR',
        HELLO = 'WORLD',
    })

    -- test that return an error with invalid file contents
    local _, err = getenv(FILENAME_INVALID)
    assert.is_nil(_)
    assert.match(err, 'unfinished string', false)

    -- test that return an error with unknown-file
    _, err = getenv('./unknown-file')
    assert.is_nil(_)
    assert.match(err, 'No.+file or directory', false)

    -- test that throws an error with invalid argument
    err = assert.throws(getenv, {})
    assert.match(err, 'filename must be string')
end
