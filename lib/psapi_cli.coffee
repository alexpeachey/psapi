fs = require 'fs'
path = require 'path'
CSON = require 'CSON'
Psapi = require './psapi.coffee'
argv = require('minimist') process.argv.slice 2
port = argv.port || argv.p || 5000
routesFile = argv.routes || argv.r

unless routesFile?
  console.log 'A routes file must be specified.'
  process.exit -1

try
  routesContent = fs.readFileSync routesFile, 'UTF-8'
catch e
  console.log 'Could not read routes file.'
  console.log e
  process.exit -2

ext = path.extname routesFile

try
  switch ext
    when '.json' then routes = JSON.parse routesContent
    when '.cson' then routes = CSON.parse routesContent
catch e
  console.log 'Could not parse routes.'
  process.exit -3


psapi = new Psapi {routes}
psapi.listen port
