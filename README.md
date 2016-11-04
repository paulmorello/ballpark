# Ballpark

Ballpark is a website designed to showcase the behind the scenes experiences and unique views of sporting events.

Users can upload images or videos of their unique experience at the game and give other users a different perspective on their favorite sports leagues.

[Website Link](https://ballparkapp.herokuapp.com/)

## Goal
The main goal for ballpark was to develop a minimum viavle product that would allow users to upload images and videos from their laptops. I wanted the site to allow for comments and display user profiles.

## Technologies Used:

This project utilsed HTML, CSS, Ruby, SQL, Active Record, Sinatra, Amazon S3, PostgreSQL Carrierwave and Fog.

## Resources Used:

* [Ruby on Rails Guides](http://guides.rubyonrails.org/)
* [Stack Overflow](http://stackoverflow.com/)
* [Amazon S3](aws.amazon.com/s3‎)
* [Draw.io](draw.io)

## Approach Taken

1. Completed wireframing and database structuring.
  * As a first step, I sketched out designs for each page to acheieve a Minimum Viable Product (MVP).

2. Enabled databases within PostgreSQL.
  * After understanding the database structure for Ballpark, the databases were created within PostgreSQL using SQL.

3. Created ERB HTML files for each wireframe design.
  * I then created each ERB file and created the basic structuring I would need for each page. No styling was done at this point.

4. Began implementing routes on Main ruby files
  * I started creating the routes for each individual page to both display pages and update databases with user information and uploaded content.

5. Validations and login restrictions created
  * Started implementing validations to restrict where users could move around the website without being logged in.
  Also set up required fields for users when completing website forms.

6. Styling and further feature implementation
  * Completed basic styling with CSS and completed features including storing file in Amazon S3 and User-profiles.

## Future Additions to the Website

* Automatically resize images when uploaded with ImageMagick Gem

* A more functional mobile design that uses the mobile camera to take pictures and videos and upload them directly to the site.

* Better sorting and post display. Optimising post display by tags and related posts.

* Display error messages when user input fails.

* The ability to favourite/like posts and store those posts in their User-profiles.

* Allow users to add profile pictures.

## Conclusion
This project was created as a part of General Assembly's Web Development Immersive course in Melbourne.
