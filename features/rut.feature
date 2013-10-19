Feature: See router uptime
  In order to see a router's uptime
  I want a one-command that print it
  So I don't have to use a admin program

  Scenario: App should have a basic UI
    When I get help for "rut"
    Then the exit status should be 0
    And the banner should be present
    And there should be a one line summary of what the app does
    And the banner should include the version
    And the banner should document that this app takes options
    And the banner should document that this app's arguments are:
      |router_ip|which is required|

  Scenario: Entering valid router ip
    When I run `rut 10.0.1.1`
    Then the exit status should be 0
    And the output from "rut 10.0.1.1" should contain "has been up"

  Scenario: Entering invalid router ip
    When I run `rut 10.0.1.2`
    Then the exit status should be 1
    And the output from "rut 10.0.1.2" should contain "Host 10.0.1.2 not responding"

  Scenario: Entering an invalid ip
    When I run `rut 999.999.999.999`
    Then the exit status should be 2
    And the output from "rut 999.999.999.999" should contain "999.999.999.999 is an invalid ip address"
  Scenario: Entering an invalid input
    When I run `rut something`
    Then the exit status should be 70
    And the output from "rut something" should contain "something is not an IP-address"
