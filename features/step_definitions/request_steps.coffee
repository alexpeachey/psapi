request = require 'request'


module.exports = ->

  @Then /^a (GET) request to (http:\/\/\S+) succeeds and returns$/, (verb, url, expected_body, done) ->
    request url, (error, response, body) ->
      expect(error).to.be.null
      expect(response.statusCode).to.equal 200
      expect(response.body).to.equal expected_body
      done()
