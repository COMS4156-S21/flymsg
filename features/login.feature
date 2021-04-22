Feature: Login User

Background: For a user
    Given I have an account

    Scenario: 
        When I go to the login page
        And I log in
        Then I am logged in

    Scenario:
        When I go to the login page
        And I log in with incorrect password
        Then I should be on the login page
        And I should see "Invalid email/password combination"

    Scenario:
        When I go to the login page
        And I log in with incorrect email
        Then I should be on the login page
        And I should see "Invalid email/password combination"

    Scenario:
        When I go to the login page
        And I log in
        And I am logged in
        And I logout
        Then I should be on the login page