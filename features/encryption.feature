Feature: Encrypt and Decode Messages with Steganography

Background: Image with Encrypted message
    
    Scenario: Encrypt and encode the message in the image
        When I go to the encrypt page
        And I upload an image "ms.png"
        And I enter the message "hello test"
        And I click encrypt
        Then I should be on the view page for "ms.png"

    Scenario: Decode and decrypt the message in the image
        When I go to the decrypt page
        And I upload an image "ms_steg.png"
        And I click decrypt
        Then I should be on the view page for "ms_steg.png"
        And I should see "hello test"

