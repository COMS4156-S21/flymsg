Feature: Encode and Decode Messages

Background: Image
    
    Scenario: Encode ASCII message and image
        When ASCII "message" and "image" are passed
        Then ASCII "message" should be encoded inside "image" 
        Then I should be on the view page for "image"
        
    Scenario: Decode ASCII message and image 
        When "image" gets passed 
        Then ASCII "message" should be decoded 
        
    Scenario: Decode through S3 bucket 
        When "image" gets passed 
        Then S3 bucket should decode ASCII "message"       

    Scenario: ASCII message bigger than image
        When ASCII "message" that is bigger than "image" is passed 
        Then Message too large for image SteganographyException "error" should be raised 
        
    Scenario: Image encoded in base64 string 
        When "image" is encoded in base64 "string"
        Then correct "string" is returned
        
    Scenario: Encoded image is added to S3 bucket 
        When "image" is encoded in base64 "string"
        Then uploaded to S3 bucket   
        
    Scenario: Encoded image is added to S3 bucket without user credentials
        When "image" is encoded in base64 "string"
        Then MissingCredentialsError should be raised   
        
    Scenario: Encoded image is attempted to be added to the S3 bucket without valid bucket name
        When "image" is encoded in base64 "string"
        Then Bucket parameter missing ArgumentError should be raised       
              
    Scenario: Encoded image is attempted to be added to the S3 bucket without valid object key
        When "image" is encoded in base64 "string"
        Then Object key parameter missing ArgumentError should be raised    
        
    Scenario: Encoded image is attempted to be added to the S3 bucket with region that is not supported by AWS 
        When "image" is encoded in base64 "string"
        Then NetworkingError should be raised       
    
    Scenario: Encoded image is attempted to be added to the S3 bucket without valid region
        When "image" is encoded in base64 "string"
        Then MissingRegionError should be raised  
