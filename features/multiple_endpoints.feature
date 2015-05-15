Feature: Multiple endpoints

  As a developer mocking a complex API with several endpoints
  I want to be able to define multiple endpoints through a single Psapi configuration
  So that my mock API exposes the same set of endpoints as my real server.


  Scenario: multiple endpoints
    Given I create a file "hello_world.cson" with the content
      """
      [
        method: "GET"
        path: "/hello"
        status: 200
        response: "world"
      ,
        method: "GET"
        path: "/foo"
        status: 200
        response: "bar"
      ]
      """
    When I run "psapi hello_world.cson"
    And wait until I see "Listening at http://localhost:5000"
    Then a GET request to http://localhost:5000/hello succeeds and returns
      """
      "world"
      """
    And a GET request to http://localhost:5000/foo succeeds and returns
      """
      "bar"
      """
