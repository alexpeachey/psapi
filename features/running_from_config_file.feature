Feature: Running off a configuration file

  As a user needing a simple static mock server for integration testing
  I want to be able to define all needed endpoints through a simple config file
  So that I can get my testing setup done quickly without having to write code.


  Scenario: CSON configuration file
    Given I create a file "hello_world.cson" with the content
      """
      [
        method: "GET"
        path: "/hello"
        status: 200
        response: "world"
      ]
      """
    When I run "psapi hello_world.cson"
    And wait until I see "Listening at http://localhost:5000"
    Then a GET request to http://localhost:5000/hello succeeds and returns
      """
      "world"
      """


  Scenario: JSON configuration file
    Given I create a file "hello_world.json" with the content
      """
      [
        {
          "method": "GET",
          "path": "/hello",
          "status": 200,
          "response": "world"
        }
      ]
      """
    When I run "psapi hello_world.json"
    And wait until I see "Listening at http://localhost:5000"
    Then a GET request to http://localhost:5000/hello succeeds and returns
      """
      "world"
      """
