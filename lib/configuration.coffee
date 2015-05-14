class Configuration

  constructor: ({argv, @CSON, @eventEmitterReader, @fs, @path}) ->
    @CSON ?= require 'CSON'
    @eventEmitterReader ?= require './event_emitter_reader.coffee'
    @fs ?= require 'fs'
    @path ?= require 'path'
    @port = argv.port or argv.p or 5000
    @routesFile = argv._[0]
    @format = @_formatFromFile(@routesFile) or argv.format or argv.f or 'json'

  getRoutes: (done) ->
    @_readRoutes (err, content) =>
      if err?
        console.log 'Could not read routes.'
        process.exit 1
      done null, @_parseRoutes content

  _parseRoutes: (content) ->
    try
      switch @format
        when 'json' then JSON.parse content
        when 'cson' then @CSON.parse content
        else @_parseError()
    catch e
      @_parseError()

  _readRoutes: (done) ->
    if @routesFile?
      @_routesFromFile done
    else
      @_routesFromPipe done

  _routesFromFile: (done) ->
    @fs.readFile @routesFile, 'UTF-8', done

  _routesFromPipe: (done) ->
    process.stdin.resume()
    process.stdin.setEncoding 'utf8'
    @eventEmitterReader process.stdin, done

  _formatFromFile: (file) ->
    return unless file?
    ext = @path.extname file
    if ext is '.json' or ext is '.cson'
      ext.slice 1

  _parseError: ->
    console.log 'Could not parse routes.'
    process.exit 2

module.exports = Configuration
