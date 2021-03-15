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
    1. rails server -e production
        1. If you need logging either use development with ‘rails server’ or production with ‘export RAILS_LOG_TO_STDOUT=1; rails server -e production’
1. Visit the localhost:3000/encrypt endpoint to embed a message into an image of choice.
    1. **NOTE**: The steganography operation is an expensive operation and takes some time to perform. Please let the page redirect by itself after you submit the form.
1. Visit the localhost:3000/decrypt endpoint to extract the message out of the image from the previous step.
1. Run the following steps to run tests:
    1. rake spec
    1. rake cucumber
1. View the coverage report at **coverage/index.html**


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
