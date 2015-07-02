_ = require 'lodash'
chalk = require 'chalk'


class Psapi

  constructor: ({routes, express, @Handlebars, parser}) ->
    express ?= require 'express'
    @Handlebars ?= require 'handlebars'
    parser ?= require 'body-parser'

    @app = express()
    @app.use parser.urlencoded extended: no
    @app.use parser.json()

    for route in routes
      @_registerRoute route


  listen: (port, done) ->
    @app.listen port, ->
      console.log "Listening at #{chalk.cyan 'http://localhost:'}#{chalk.cyan port}"
      done()


  _registerRoute: ({method, path, status, response}) ->
    console.log "Registering route #{chalk.green method.toUpperCase()} #{chalk.cyan path}"
    @app[method.toLowerCase()] path,
                               @_createRequestHandler(response, status)


  _createRequestHandler: (response, status) =>
    payload = @_prepPayload response
    (req, res) =>
      context = _.merge {}, req.params, req.query, req.body
      res.status(status or 200).json @_executePayload(payload, context)


  _prepPayload: (data) ->
    switch
      when _.isArray data then => _.map data, (item) => @_prepPayload item
      when _.isObject data then => _.mapValues data, (value) => @_prepPayload value
      when _.isString data then @Handlebars.compile data
      else -> data


  _executePayload: (data, context) ->
    result = data context
    switch
      when _.isArray result then _.map result, (item) => @_executePayload item, context
      when _.isObject result then _.mapValues result, (value) => @_executePayload value, context
      else result



module.exports = Psapi
