# Pseudo API

[![Build Status](https://travis-ci.org/Originate/psapi.svg?branch=master)](https://travis-ci.org/Originate/psapi)

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
`psapi -r routes.cson`

You can now hit your API:
`http://localhost:5000/books`

## TODO

* Build out feature specs

