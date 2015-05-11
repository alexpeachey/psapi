fsExtra = require 'fs-extra'
path = require 'path'


module.exports = ->

  @Given /^I create a file "([^"]*)" with the content$/, (filename, content, done) ->
    fsExtra.outputFile path.join(@tmpDir, filename),
                       content,
                       done
