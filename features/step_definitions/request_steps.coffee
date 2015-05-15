request = require 'request'
{waitUntilServerListensOnPort} = require '../support/wait_helpers'


module.exports = ->

  @Then /^a (GET) request to (\S+) succeeds and returns$/, (verb, url, expected_body, done) ->
    request url, (error, response, body) ->
      expect(error).to.be.null
      expect(response.statusCode).to.equal 200
      expect(response.body).to.equal expected_body
      done()


  @Then /^my mock server listens on port (\d+)$/, (port, done) ->
    waitUntilServerListensOnPort @process, port, ->
      request "http://localhost:#{port}", (error, response, body) ->
        expect(error).to.be.null
        expect(response.statusCode).to.equal 200
        expect(response.body).to.equal '"yes"'
        done()
