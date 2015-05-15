chalk = require 'chalk'
config = require '../package.json'
Configuration = require './configuration.coffee'
minimist = require 'minimist'
Psapi = require './psapi.coffee'

argv = minimist process.argv.slice 2
configuration = new Configuration({argv})
configuration.getRoutes (_, routes) ->
  console.log chalk.bold "#{config.description} v#{config.version}\n"
  psapi = new Psapi {routes}
  psapi.listen configuration.port
  console.log '\nPress Ctrl-C to stop...'
