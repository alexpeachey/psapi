Feature: Running off a configuration file

  As a user needing a simple static mock server for integration testing
  I want to be able to define all needed endpoints through a simple config file
  So that I can get my testing setup done quickly without having to write code.


  Scenario: CSON configuration file
    Given I create a file "hello_world.cson" with the content
      """
      [
        method: "get"
        path: "/hello"
        status: 200
        response: "world"
      ]
      """
    When I run "psapi -r hello_world.cson"
    And wait until I see "Listening on 5000"
    Then a GET request to http://localhost:5000/hello succeeds and returns
      """
      "world"
      """


  Scenario: JSON configuration file
    Given I create a file "hello_world.json" with the content
      """
      [
        {
          "method": "get",
          "path": "/hello",
          "status": 200,
          "response": "world"
        }
      ]
      """
    When I run "psapi -r hello_world.json"
    And wait until I see "Listening on 5000"
    Then a GET request to http://localhost:5000/hello succeeds and returns
      """
      "world"
      """
