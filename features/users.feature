Feature: Users creation

Background: For a new user
    
    Scenario:
        Given I do not have an account
        When I go to the new users page
        And I fill in "email" with "akhil@akhil.com"
        And I fill in "first_name" with "akhil"
        And I fill in "last_name" with "ravipati"
        And I fill in "pwd" with "akhil"
        And I press "commit"
        Then I should be on the login page
        And I log in
        Then I am logged in

    Scenario:
        Given I do not have an account
        When I go to the new users page
        And I fill in "email" with "akhil@akhil.com"
        And I fill in "first_name" with "akhil"
        And I fill in "last_name" with ""
        And I fill in "pwd" with "akhilakhilakhilakhil"
        And I press "commit"
        Then I should be on the new users page
        And I should see "Please provide last name"

    Scenario:
        Given I do not have an account
        When I go to the new users page
        And I fill in "email" with "akhil@akhil.com"
        And I fill in "first_name" with ""
        And I fill in "last_name" with "akhil"
        And I fill in "pwd" with "akhilakhilakhilakhil"
        And I press "commit"
        Then I should be on the new users page
        And I should see "Please provide first name"

    Scenario:
        Given I have an account
        When I go to the new users page
        And I fill in "email" with "akhil@akhil.com"
        And I fill in "first_name" with "akhil"
        And I fill in "last_name" with "ravipati"
        And I fill in "pwd" with "akhil"
        And I press "commit"
        Then I should be on the new users page
        And I should see "Email already in use"