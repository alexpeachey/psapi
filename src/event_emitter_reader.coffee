module.exports = (stream, done) ->
  content = ''
  stream.on 'data', (data) -> content += data
  stream.on 'end', -> done null, content
