request = require 'request'
{wait} = require 'wait'


module.exports = ->

  @Then /^a (GET) request to (http:\/\/\S+) succeeds and returns$/, (verb, url, expected_body, done) ->
    wait 10, ->
      request url, (error, response, body) ->
        expect(error).to.be.null
        expect(response.statusCode).to.equal 200
        expect(response.body).to.equal expected_body
        done()


  @Then /^my mock server listens on port (\d+)$/, (port, done) ->
    wait 10, ->
      request "http://localhost:#{port}", (error, response, body) ->
        expect(error).to.be.null
        expect(response.statusCode).to.equal 200
        expect(response.body).to.equal '"yes"'
        done()
