Feature: Running off piped input

  As a user needing a simple static mock server for integration testing
  I want to be able to pipe my config into the server
  So that I can have another program generate my config.


  Scenario: CSON configuration
    Given I pipe the following data into "psapi --format=cson"
      """
      [
        method: "get"
        path: "/hello"
        status: 200
        response: "world"
      ]
      """
    And wait until I see "Listening at http://localhost:5000"
    Then a GET request to http://localhost:5000/hello succeeds and returns
      """
      "world"
      """


  Scenario: JSON configuration
    Given I pipe the following data into "psapi --format=json"
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
    And wait until I see "Listening at http://localhost:5000"
    Then a GET request to http://localhost:5000/hello succeeds and returns
      """
      "world"
      """
