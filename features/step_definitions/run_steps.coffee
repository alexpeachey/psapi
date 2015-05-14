spawn = require 'cross-spawn'
{wait} = require 'wait'

module.exports = ->

  @When /^I run "([^"]*)"$/, (full_command, done) ->
    [command, args...] = full_command.split ' '
    command = @psapiPath if command is 'psapi'
    @process = spawn command,
                     args,
                     cwd: @tmpDir
    @process.on 'error', (err) ->
      console.log 'ERROR!'
      throw err
    @process.on 'exit', (@exit_code) =>
    done()


  @Given /^I pipe the following data into "([^"]*)"$/, (full_command, content, done) ->
    [command, args...] = full_command.split ' '
    command = @psapiPath if command is 'psapi'
    @process = spawn command,
                     args,
                     cwd: @tmpDir
    @process.stdin.write content
    @process.stdin.end()
    done()


  @When /^wait until I see "(.*)"$/, (expected_text, done) ->
    output = ''
    found = no
    @process.stdout.on 'data', (data) ->
      output += data.toString()
      if output.indexOf(expected_text) > -1 and not found
        found = yes
        process.nextTick done


  @Then /^I see "(.*)"$/, (expected_text, done) ->
    output = ''
    @process.stdout.on 'data', (data) ->
      output += data.toString()
      done() if output.indexOf(expected_text) > -1


  @Then /^the command exits with status (\d+)$/, (expected_exit_code, done) ->
    # In order to verify exit codes, we have to wait a bit longer,
    # so that the error event from the app has time to make it through the event loop.
    wait 10, =>
      expect(@exit_code).to.equal parseInt(expected_exit_code)
      done()
