tmp = require 'tmp'


module.exports = ->

  @Before (done) ->
    tmp.dir unsafeCleanup: yes,
            (err, @tmpDir) => done err


  @After (done) ->
    @process.kill()
    done()
