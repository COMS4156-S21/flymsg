Feature: Users creation

Background: For a new user
    Given I do not have an account
    
    Scenario:
        When I go to the new users page
        And I fill in "email" with "akhil@akhil.com"
        And I fill in "first_name" with "akhil"
        And I fill in "last_name" with "ravipati"
        And I fill in "pwd" with "akhil"
        And I press "commit"
        Then I should be on the login page
        And I log in
        Then I am logged in