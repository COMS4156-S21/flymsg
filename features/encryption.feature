Feature: Encrypt and Decode Messages with Steganography

Background: Image with Encrypted message
    Given user test has an account
    And user test logs in
    And user test is logged in
    
    Scenario: Encrypt and encode the message in the image
        When I go to the encrypt page
        And I upload an image "ms.png" for encryption
        And I enter the message "hello test"
        And I click encrypt
        Then I should be on the view page for "ms.png"

    Scenario: Decode and decrypt the message in the image with sender email
        When I go to the decrypt page
        And I upload an image "ms.png" for decryption
        And I enter test user email for decryption
        And I click decrypt
        Then I should be on the view page for "hello test"
        And I should see "hello test"

    Scenario: Encrypt and encode the message in the image with receiver email
        When I go to the encrypt page
        And I follow "targeted_true"
        And I upload an image "ms.png" for encryption
        And I enter test user email for encryption
        And I enter the message "hello test"
        And I click encrypt
        Then I should be on the view page for "ms.png"

    Scenario: Decode and decrypt the message in the image
        When I go to the decrypt page
        And I follow "targeted_true"
        And I upload an image "ms.png" for decryption
        And I click decrypt
        Then I should be on the view page for "hello test"
        And I should see "hello test"

    Scenario: Encrypt and encode the message in the image with incorrect receiver email
        When I go to the encrypt page
        And I follow "targeted_true"
        And I upload an image "ms.png" for encryption
        And I enter random user email for encryption
        And I enter the message "hello test"
        And I click encrypt
        Then I should be on the encrypt page
        And I should see "No such user found!"

    Scenario: Decode and decrypt the message in the image with incorrect sender email
        When I go to the decrypt page
        And I follow "targeted_false"
        And I upload an image "ms.png" for decryption
        And I enter random user email for decryption
        And I click decrypt
        Then I should be on the decrypt page
        And I should see "No such user found!"


