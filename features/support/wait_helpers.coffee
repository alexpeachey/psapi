{wait} = require 'wait'


waitHelpers =

  # Waits until the given stream contains the given text
  waitUntilStreamContains: (stream, text, done) ->
    output = ''
    found = no
    stream.on 'data', (data) ->
      output += data.toString()
      if output.indexOf(text) > -1 and not found
        found = yes
        done()


  waitUntilServerListensOnPort: (process, port, done) ->
    waitHelpers.waitUntilStreamContains process.stdout,
                                        "Listening at http://localhost:#{port}",
                                        -> wait 1, done



module.exports = waitHelpers
