class Psapi
  constructor: ({routes, express, @Handlebars, parser}) ->
    express ?= require 'express'
    @Handlebars ?= require 'Handlebars'
    parser ?= require 'body-parser'
    @app = express()
    @app.use parser.urlencoded extended: no
    @app.use parser.json()
    for route in routes
      {method, path, response, status} = route
      payload = @prepPayload response
      console.log "Registering route #{method} #{path}"
      @app[method] path, @routeHandler(method, path, payload, status)

  listen: (port) ->
    console.log "Listening on #{port}"
    @app.listen port

  routeHandler: (method, path, payload, status) =>
    (req, res) =>
      context = {}
      for key, value of req.params
        context[key] = value
      for key, value of req.query
        context[key] = value
      for key, value of req.body
        context[key] = value
      console.log req.body
      console.log context
      status = status or 200
      res.status(status).json @executePayload(payload, context)

  prepPayload: (data) ->
    if typeIsArray data
      result = (@prepPayload item for item in data)
      -> result
    else if typeof data is 'object'
      processed = {}
      for key, value of data
        processed[key] = @prepPayload value
      -> processed
    else if typeof data is 'string'
      @Handlebars.compile data
    else
      -> data

  executePayload: (data, context) ->
    result = data context
    if typeIsArray result
      (@executePayload item, context for item in result)
    else if typeof result is 'object'
      processed = {}
      for key, value of result
        processed[key] = @executePayload value, context
      processed
    else if typeof result is 'function'
      data context
    else
      result


  typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'


module.exports = Psapi
