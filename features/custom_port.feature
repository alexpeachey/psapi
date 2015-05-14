Feature: customizing the port

  As a developer simulating servers that run on specific ports
  I want to be able to specify the port at which my mock server runs
  So that my mock server is a realistic stand-in for the real server.


  Background:
    Given I have a config file named "server.cson"


  Scenario: default port
    When I run "psapi server.cson"
    And wait until I see "Listening at http://localhost:5000"
    Then my mock server listens on port 5000


  Scenario: specifying the port on the command line
    When I run "psapi -p 4000 server.cson"
    And wait until I see "Listening at http://localhost:4000"
    Then my mock server listens on port 4000
