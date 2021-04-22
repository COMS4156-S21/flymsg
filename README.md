# Iteration 1

## Team Members
1. Jainam Chirag Shah - jcs2281
1. Varun Jasti - vj2252
1. Priyanka Mishra - pm3105
1. Akhil Ravipati - ar4160


## Instructions for local setup
1. Clone project from https://github.com/COMS4156-S21/flymsg and use the **master** branch and **iteration-1** tag/release.
1. Run the following commands to set up necessary native libraries for gem installation:
    1. sudo apt-get update
    1. sudo apt-get install sqlite3 libsqlite3-dev
    1. sudo apt-get install libmagick++-dev
    1. sudo apt-get install libpq-dev
1. Move to the cloned directory of the project
1. Run the following commands to run it locally:
    1. bundle install
    1. rails webpacker:install   # (if required)
    1. rails server -e production
        1. If you need logging either use development with ‘rails server’ or production with ‘export RAILS_LOG_TO_STDOUT=1; rails server -e production’
1. Visit the localhost:3000/encrypt endpoint to embed a message into an image of choice.
    1. **NOTE**: The steganography operation is an expensive operation and takes some time to perform. Please let the page redirect by itself after you submit the form.
1. Visit the localhost:3000/decrypt endpoint to extract the message out of the image from the previous step.
1. Run the following steps to run tests:
    1. rake spec
    1. rake cucumber
1. View the coverage report at **coverage/index.html**


## Secret setup - for the app
1. heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)


## Links

**Github**: https://github.com/COMS4156-S21/flymsg

**Heroku**: https://calm-meadow-89750.herokuapp.com



## User Scenarios:
User scenarios are documented in the **features/** folder. There are RSpecs in the **spec/** folder. The current coverage report stands at 96%. It is subject to change as we make a few more modifications. But the scenarios cover the intended outcomes of iteration 1.



## Summary of the iteration:
The core part of our project was getting the image steganography code working and enabling encrypt and decrypt functions to embed secret messages into images and extract them from the stego images respectively.

To that end, we have the following endpoints:
1. **/encrypt**: It has a form to upload an image and write the message that should get embedded into it. It redirects to a /view page to display the stego image which has the message embedded into the uploaded image. This image can then be downloaded.
1. **/decrypt**: It has a form to upload a stego image and get the embedded message out of it. It displays the message on the same endpoint.
1. **/view**: As mentioned above, it is the landing page after an encrypt operation to view and download the stego image.



## Documentation: 
1. The **lib** folder contains the ruby files for performing the steganography. **steganography.rb** file stores in itself the image data. It then provides an encode method to take the secret message and output file name to store the stego image in. Similarly a decode method to take the image path and return the message string. 
1. We use an initializer in **config/initializers/storage_setup.rb** to create local dirs for storing images inside the app. We will eventually move out to amazon aws s3.
1. The **app/controllers** folder contains the 3 controllers for our app: **decrypt_controller.rb, encrypt_controller.rb, view_controller**.rb performing the operations corresponding to the steganography library file.
1. The **app/views** folder contains the 3 view folders for each controller to display the related pages.



## Next Iteration Plans:
1. Enable user login and allow for creating multiple public, private keys.
1. Move storage to Amazon s3 and create tables and databases in Postgres either on Heroku or again on Amazon s3 to store login and key data.
1. Allow users to embed messages using a target’s public keys to allow only that person to view the message.
1. Beautify the app.


---


# Iteration 2

## Team Members
1. Jainam Chirag Shah - jcs2281
1. Varun Jasti - vj2252
1. Priyanka Mishra - pm3105
1. Akhil Ravipati - ar4160


## Instructions for local setup
1. Clone project from https://github.com/COMS4156-S21/flymsg and use the **itr2** branch and **iteration-2** tag/release.
1. Run the following commands to set up necessary native libraries for gem installation:
    1. sudo apt-get update
    1. sudo apt-get install sqlite3 libsqlite3-dev
    1. sudo apt-get install libmagick++-dev
    1. sudo apt-get install libpq-dev
1. Move to the cloned directory of the project
1. Run the following commands to run it locally:
    1. bundle install
    1. rails webpacker:install
    1. rake db:reset db:migrate db:seed
    1. rails server
1. Visit the localhost:3000/create endpoint to create your account.
    1. Or you can skip this step and use the test account username: test@test.com , password: test
1. Visit the localhost:3000/login endpoint to login.
1. Visit the localhost:3000/encrypt endpoint to encrypt an image. There are 2 ways to go about this:
    1. Click on "Public" tab to encrypt your secret message with your private key and then embed into the image. Your friends who have this image will be able to decrypt it on flymsg if they also mention your email.
    1. Click on "Targeted" tab and provide the email of your friend (who is also on flymsg), to encrypt your secret message with your friend's private key. Only that particular friend will be able to decrypt it on flymsg.
    1. You can create an account for yourself and then another to act as the friend to test this out (or use the default test account).
1. Visit the localhost:3000/decrypt endpoint to extract the message out of the image from the previous step. Again, there are 2 ways to go about this:
    1. Click on the "Public" tab and provide the image and the email of your friend who "Public" encrypted that image with their secret message.
    1. Click on the "Targeted" tab and provide the image which your friend "Targeted" encrypted that image with their secret message using your email.
1. Visit the localhost:3000/logout endpoint to logout.
1. Run the following steps to run tests:
    1. rake spec
    1. rake cucumber
1. View the coverage report at **coverage/index.html**


## Secret setup - for the app
1. heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)


## Links

**Github**: https://github.com/COMS4156-S21/flymsg (itr2 branch)

**Heroku**: https://mysterious-tundra-81467.herokuapp.com



## User Scenarios:
User scenarios are documented in the **features/** folder. There are RSpecs in the **spec/** folder. The current coverage report stands at 96%. It is subject to change as we make a few more modifications. But the scenarios cover the intended outcomes of iteration 2.



## Summary of the iteration 2:
With the core steganography implemented in the last iteration, during this iteration we focused on secret message encryption & decryption using public & private keys. We also improved the UI, added a login & create user feature. We also added related models and tests.

To that end, we have the following endpoints:
1. **/login**: Allows users to login.
1. **/create**: Allows users to create new accounts.
1. **/encrypt**: It has a form to upload an image and write the message that should get embedded into it. It redirects to a /view page to display the stego image which has the message embedded into the uploaded image. This image can then be downloaded. In **this iteration** this endpoint allows additional features of encrypting messages using public or private keys. 
    1. If a message is intended for many people, then the user can choose to "Public" encrypt the secret message where the message is encrypted using the user's private keys and then embedded into the image. Anyone who knows this user can then decrypt it using that user's public key (by providing the user's email in decrypt endpoint).
    1. If a message is intended for one particular person, then the user can choose to "Targeted" encrypt the secret message by providing that person's email, where the secret message is encrypted with that person's public key and then embedded into the image. Now this person can decrypt it normally from the decrypt endpoint.
    1. Apart from that, this endpoint intends to integrate with AMAZON S3 for storage of these images. The code is ready, but it hasn't been integrated into the flow.
1. **/decrypt**: It has a form to upload a stego image and get the embedded message out of it. It displays the message on the same endpoint. In **this iteration** this endpoint allows additional features of decrypting messages using public or private keys.
    1. If the message was encrypted by someone using "Public" encryption, meaning it was intended to lot of people, then the user can "Public" decrypt the image by providing the source user's email, where the source user's public key is used to decrypt the message after it is stripped from the image.
    1. If the message was encrypted by someone specifically for this user, then the user can "Targeted" decrypt the image, where the user's private key is used to decrypt the message after it is stripped from the image.
1. **/view**: As mentioned above, it is the landing page after an encrypt operation to view and download the stego image.
1. **/logout**: Allows users to logout.



## Documentation (new stuff in iteration 2): 
1. The **lib** folder contains the ruby files for performing the encryption. **encryption.rb** file provides various methods to create new keys, encrypt and decrypt using private and public keys, hash passwords, compare hashed passwords etc.
1. The **app/models** folder contains 5 new models, of which 2 (**user.rb**, **user_key.rb**) are being used actively in the app right now.
1. The **app/controllers** folder contains the 5 controllers for our app: **decrypt_controller.rb, encrypt_controller.rb, view_controller, users_controller.rb, sessions_controller.rb**. The first 3 have been update to handle the additional private key/public key encryption and decryption. The users controller handles the user creation and the sessions controller handles the sessions for logged in users.
1. The **app/views** folder contains the 5 view folders for each controller to display the related pages. The UI has been updated.


## References:
1. https://hackernoon.com/building-a-simple-session-based-authentication-using-ruby-on-rails-9tah3y4j
2. https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html


## Next Iteration Plans:
1. Enable users to send the image messages from within the app.
1. Enable amazon S3 integration and time-to-live settings.
1. Improve UI.

# Iteration Launch 

## Team Members
1. Jainam Chirag Shah - jcs2281
1. Varun Jasti - vj2252
1. Priyanka Mishra - pm3105
1. Akhil Ravipati - ar4160


## Instructions for local setup
1. Clone project from https://github.com/COMS4156-S21/flymsg and use the **final** branch and **final** tag/release.
1. Run the following commands to set up necessary native libraries for gem installation:
    1. sudo apt-get update
    1. sudo apt-get install sqlite3 libsqlite3-dev
    1. sudo apt-get install libmagick++-dev
    1. sudo apt-get install libpq-dev
1. Move to the cloned directory of the project
1. Run the following commands to run it locally:
    1. bundle install
    1. rails webpacker:install
    1. rake db:reset db:migrate db:seed
    1. rails server
1. Visit the localhost:3000/create endpoint to create your account.
    1. Or you can skip this step and use the test account username: test@test.com , password: test
1. Visit the localhost:3000/create endpoint to sign up and create a new account if you do not already have an account.
1. Visit the localhost:3000/create endpoint to check if an account with your email already exists if you are not sure whether you already have an account or not.
1. Visit the localhost:3000/login endpoint to login if you already have account or after creating an account.
1. Visit the localhost:3000/encrypt endpoint to encrypt an image. There are 2 ways to go about this:
    1. Click on "Public" tab to encrypt your secret message with your private key and then embed into the image. Your friends who have this image will be able to decrypt it on flymsg if they also mention your email.
    1. Click on "Targeted" tab and provide the email of your friend (who is also on flymsg), to encrypt your secret message with your friend's private key. Only that particular friend will be able to decrypt it on flymsg.
    1. You can create an account for yourself and then another to act as the friend to test this out (or use the default test account).
1. Visit the localhost:3000/decrypt endpoint to extract the message out of the image from the previous step. Again, there are 2 ways to go about this:
    1. Click on the "Public" tab and provide the image and the email of your friend who "Public" encrypted that image with their secret message.
    1. Click on the "Targeted" tab and provide the image which your friend "Targeted" encrypted that image with their secret message using your email.
1. Visit the localhost:3000/logout endpoint to logout.
1. Run the following steps to run tests:
    1. rake spec
    1. rake cucumber
1. View the coverage report at **coverage/index.html**


## Secret setup - for the app
1. heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)


## Links

**Github**: https://github.com/COMS4156-S21/flymsg (final branch)

**Heroku**: https://mysterious-tundra-81467.herokuapp.com



## User Scenarios:
User scenarios are documented in the **features/** folder. There are RSpecs in the **spec/** folder. The current coverage report stands at 95.25%. It is subject to change as we make a few more final modifications after the course is finished. But the scenarios cover the intended outcomes of the launch iteration.



## Summary of the iteration launch:
Iteration 2 implemented secret message encryption & decryption using public & private keys along with improving the UI, adding a login & creating user feature. This launch iteration focuses on keeping proper track of user accounts and provided mechanism for new user accounts to be saved once created. Also, polishing work was done to improve the user experience for the previous features implemented in itr2 and first iteration where new error messages were added along with bug fixes and more testing to verify the robustness of the application. All related models and tests were also added. Work was done on implementing new features such as enabling S3 Integration and Time to Live settings along with additing functionality for users to send messages within the application. However due to time limitations, this was not able to be released and pushed into final branch. Plan to finish this later on as we contiue working on this application after the course. 

To that end, we have the following endpoints:
1. **/login**: Allows users to login if there is an existing account for the user. If not, create endpoint below can be used to create an account.
1. **/create**: Allows users to create new accounts and to check if an account already exists with their email when user not sure if they already have an account.
1. **/encrypt**: It has a form to upload an image and write the message that should get embedded into it. It redirects to a /view page to display the stego image which has the message embedded into the uploaded image. This image can then be downloaded. In **this iteration** this endpoint allows additional features of encrypting messages using public or private keys. 
    1. If a message is intended for many people, then the user can choose to "Public" encrypt the secret message where the message is encrypted using the user's private keys and then embedded into the image. Anyone who knows this user can then decrypt it using that user's public key (by providing the user's email in decrypt endpoint).
    1. If a message is intended for one particular person, then the user can choose to "Targeted" encrypt the secret message by providing that person's email, where the secret message is encrypted with that person's public key and then embedded into the image. Now this person can decrypt it normally from the decrypt endpoint.
    1. Apart from that, this endpoint integrates with AMAZON S3 for storage of these images. The code for integration is a work in progress, but basic infrastructure for storing images into the AMAZON S3 Bucket have been set up. Plan to release at future date. 
    1. Work is in progress to allow users the ability to choose an existing image on the application to do their message encryption on so the users can send encrypted image messages within the application. Plan to release at future date. 
1. **/decrypt**: It has a form to upload a stego image and get the embedded message out of it. It displays the message on the same endpoint. This endpoint allows additional features of decrypting messages using public or private keys.
    1. If the message was encrypted by someone using "Public" encryption, meaning it was intended to lot of people, then the user can "Public" decrypt the image by providing the source user's email, where the source user's public key is used to decrypt the message after it is stripped from the image.
    1. If the message was encrypted by someone specifically for this user, then the user can "Targeted" decrypt the image, where the user's private key is used to decrypt the message after it is stripped from the image.
1. **/view**: As mentioned above, it is the landing page after an encrypt operation to view and download the stego image.
1. **/logout**: Allows users to logout.



## Documentation (new stuff in iteration launch): 
1. The **lib** folder contains the ruby files for performing the encryption. **encryption.rb** file provides various methods to create new keys, encrypt and decrypt using private and public keys, hash passwords, compare hashed passwords etc.
1. The **app/models** folder contains 5 new models, of which 2 (**user.rb**, **user_key.rb**) are being used actively in the app right now.
1. The **app/controllers** folder contains the 5 controllers for our app: **decrypt_controller.rb, encrypt_controller.rb, view_controller, users_controller.rb, sessions_controller.rb**. The users_controller.rb file is modified to add logic for checking for existing users and keeping track.
1. The **app/views** folder contains the 5 view folders for each controller to display the related pages. The UI has been updated.
1. The features/users.feature file has new user scenarios added to test for if user account already exists to inform user of existing account and to create new account if user account does not exist. 
1. The app/controllers/users_controller.rb file has updated error messages in event of failure sceanarios. 
1. The spec/routes/users_spec.rb has updated tests for new scenarios and functionality implemented in the code regarding new user account creation and checking if user account already exists. 
1. The spec/controllers/users_controller_spec.rb file has updated tests for new login parameter values added to improve functionality. 
1. The  app/controllers directory has files which have updated error message handling logic added in case of users coming across failure events.
1. Updated views are added to the files in the app/views/users directory to improve UI experience for users

## References:
1. https://hackernoon.com/building-a-simple-session-based-authentication-using-ruby-on-rails-9tah3y4j
2. https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/s3-example-upload-bucket-item.html


## Continuing Plans/Next Iteration Plans:
1. Improve user experience with continued bug fixes 
1. Finish working on ability to allow users to send the image messages from within the application.
1. Finish Amazon S3 integration and time-to-live settings.
1. Improve UI.

