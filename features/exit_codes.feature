Feature: Exit codes

  As a developer using Psapi in my workflow toolchain
  I want to know through exit codes if the program exited because of issues
  So that my workflows don't block on a misconfigured mock server.


  Scenario: Non-existing routes file
    When I run "psapi zonk.coffee"
    Then I see "Could not read routes"
    And the command exits with status 1


  Scenario: broken configuration file
    Given I create a file "broken.json" with the content
      """
      [
        method:
      ]
      """
    When I run "psapi broken.json"
    Then I see "Could not parse routes"
    And the command exits with status 2

