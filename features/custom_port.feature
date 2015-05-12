Feature: customizing the port

  As a developer simulating servers that run on specific ports
  I want to be able to specify the port at which my mock server runs
  So that my mock server is a realistic stand-in for the real server.


  Scenario: specifying the port on the command line
    Given I have a config file named "server.cson"
    When I run "psapi -p 4000 -r server.cson"
    And wait until I see "Listening on 4000"
    Then my mock server listens on port 4000
