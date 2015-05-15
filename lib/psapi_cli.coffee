chalk = require 'chalk'
config = require '../package.json'
Configuration = require './configuration.coffee'
minimist = require 'minimist'
Psapi = require './psapi.coffee'


console.log chalk.bold "#{config.description} v#{config.version}\n"

configuration = new Configuration argv: minimist(process.argv.slice 2)
configuration.getRoutes (_, routes) ->
  psapi = new Psapi {routes}
  psapi.listen configuration.port
  console.log '\nPress Ctrl-C to stop...'
