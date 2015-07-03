# Pseudo API

[![Build Status](https://travis-ci.org/Originate/psapi.svg?branch=master)](https://travis-ci.org/Originate/psapi)
[![Dependency Status](https://david-dm.org/Originate/psapi.svg)](https://david-dm.org/Originate/psapi)

Create a mock api server suitable for testing API functionality.

Create an array of objects defining your end points and then fire up the server.

```javascript
var routes = [
  {
    method: "get",
    path: "/books",
    status: 200,
    response: [
      { id: 1, title: "War and Peace"},
      { id: 2, title: "Goodnight Moon"}
    ]
  }
];
var Psapi = require('psapi');
var psapi = new Psapi({routes: routes});
psapi.listen(5000);
```

Included is an executable you can use.
Simply create a `json` or `cson` file defining your end points.

```cson
[
  method: "get"
  path: "/books"
  status: 200
  response: [
    id: 1
    title: "War and Peace"
  ,
    id: 2
    title: "Goodnight Moon"
  ]
]
```

Then fire up the server:
`psapi routes.cson`

You can now hit your API:
`http://localhost:5000/books`

The cli can also take piped input so if you have another program capable
of generating the route configuration, you can pipe its output into the
cli program. When using this mode, you can indicate what the format is.
If you do not indicate the format, the `json` format will be assumed.

`routeGenerator | psapi --format=cson`

## Contributing

Contributions to the project are welcomed and encouraged.
If you would like to contribute:

1. Fork the repository
1. Create a feature specification for your change
1. Add the functionality to satisfy the feature
1. Verify all specs pass with `npm test`
1. Open a Pull Request and reference any `Issue` you might be trying resolve
