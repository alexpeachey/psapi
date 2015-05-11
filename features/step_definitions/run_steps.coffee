spawn = require 'cross-spawn'


module.exports = ->

  @When /^I run "([^"]*)"$/, (full_command, done) ->
    [command, args...] = full_command.split ' '
    command = @psapiPath if command is 'psapi'
    @process = spawn command,
                     args,
                     cwd: @tmpDir
    done()


  @When /^wait until I see "(.*)"$/, (expected_text, done) ->
    output = ''
    @process.stdout.on 'data', (data) ->
      output += data.toString()
      done() if output.indexOf(expected_text) > -1
