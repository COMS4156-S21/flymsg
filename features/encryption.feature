Feature: Encrypt and Decode Messages with Steganography

Background: Image with Encrypted message
    Given test user has an account
    And test user logs in
    And test user is logged in
    
    Scenario: Encrypt and encode the message in the image
        When I go to the encrypt page
        And I upload an image "ms.png" for encryption
        And I enter the message "hello test"
        And I click encrypt
        Then I should be on the view page for "ms.png"

    Scenario: Decode and decrypt the message in the image
        When I go to the decrypt page
        And I upload an image "ms.png" for decryption
        And I enter test user email
        And I click decrypt
        Then I should be on the view page for "hello test"
        And I should see "hello test"

