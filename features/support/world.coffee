require '../../spec/spec_helper.coffee'
path = require 'path'


class World

  # path to the psapi binary
  psapiPath: path.join __dirname, '..', '..', 'bin', 'psapi'


  # Cucumber needs the World constructor to take a callback
  constructor: (done) ->
    done()



# Cucumber expects a 'World' attribute on all testing objects
module.exports = ->
  @World = World
