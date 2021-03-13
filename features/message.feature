Feature: Encode and Decode Messages

Background: Image
    
    Scenario: Encode ASCII message and image
        When ASCII "message" and "image" are passed
        Then ASCII "message" should be encoded inside "image" 
        Then I should be on the view page for "image"
        
    Scenario: Decode ASCII message and image 
        When "image" gets passed 
        Then ASCII "message" should be decoded 
        
    Scenario: Encode Non-ASCII message and image 
        When Illegal "message" that is not ASCII is passed with "image" 
        Then NON-ASCII SteganographyException "error" should be raised 
        
    Scenario: ASCII message bigger than image
        When ASCII "message" that is bigger than "image" is passed 
        Then Message too large for image SteganographyException "error" should be raised 
        
    Scenario: Image encoded in base64 string 
        When "image" is encoded in base64 "string"
        Then correct "string" is returned
    
    

