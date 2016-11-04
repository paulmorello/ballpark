require 'sinatra'
require 'fog'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require_relative 'db_config'
require_relative 'models/video'
require_relative 'models/my_uploader'
require_relative 'models/photo'
require_relative 'models/user'
require_relative 'models/sport'
require_relative 'models/comment'
require 'pry'

# Used to create sessions for logged in users
enable :sessions

# Helpers used to assist the user functionality of the site and improve
# validations.
helpers do

  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end


get '/' do

  redirect to '/login/new' unless logged_in?

  @videos = Video.all.reverse_order
  @photos = Photo.all.reverse_order

  erb :index
end

# Create a new video page, is stored in Amazon S3
get '/videos/new' do

  redirect to '/login/new' unless logged_in?

  @sports = Sport.all

  erb :videos_new
end

# stores the video in postgres database
post '/videos' do

  video = Video.new
  video.title = params[:title]
  video.sport_id = params[:sport_id]
  video.description = params[:description]
  video.video = params[:video]
  video.user_id = current_user.id
  video.save

  redirect to '/'
end

# User can upload a new photo, is stored in Amazon S3
get '/photos/new' do

  redirect to '/login/new' unless logged_in?

  @sports = Sport.all

  erb :photos_new
end

# stores the photo in the postgres database
post '/photos' do

  photo = Photo.new
  photo.title = params[:title]
  photo.sport_id = params[:sport_id]
  photo.description = params[:description]
  photo.image = params[:image]
  photo.user_id = current_user.id
  photo.save

  redirect to '/'

end

# Show pages where users can interact with posts
get '/videos/:id' do

  @video = Video.find_by(id: params[:id])
  @comments = Comment.where(video_id: @video.id).reverse_order

  erb :video_show
end

get '/photos/:id' do

  @photo = Photo.find_by(id: params[:id])
  @comments = Comment.where(photo_id: @photo.id).reverse_order

  erb :photo_show
end


get '/videos/:id/edit' do

  redirect to '/login/new' unless logged_in?

  @video = Video.find_by(id: params[:id])
  @sports = Sport.all

  if @video.user_id == current_user.id
    erb :video_edit
  else
    redirect to "/videos/#{params[:id]}"
  end
end

# Updates the post in the database, storing the new values.
post '/videos/:id' do

  video = Video.find_by(id: params[:id])
  video.update(title: params[:title], sport_id: params[:sport_id], description: params[:description], video: params[:video])

  redirect to "/videos/#{params[:id]}"
end

get '/photos/:id/edit' do

  redirect to '/login/new' unless logged_in?

  @photo = Photo.find_by(id: params[:id])
  @sports = Sport.all

  if @photo.user_id == current_user.id
    erb :photo_edit
  else
    redirect to "/photos/#{params[:id]}"
  end
end

post '/photos/:id' do

  photo = Photo.find_by(id: params[:id])
  photo.update(title: params[:title], sport_id: params[:sport_id], description: params[:description], image: params[:image])

  redirect to "/photos/#{params[:id]}"
end

# Stores the new comment in postgres
post '/comments/video' do

  redirect to '/login/new' unless logged_in?

  comment = Comment.new
  comment.body = params[:body]
  comment.video_id = params[:video_id]
  comment.user_id = current_user.id
  comment.save

  redirect to "/videos/#{comment.video_id}"
end

post '/comments/photo' do

  redirect to '/login/new' unless logged_in?

  comment = Comment.new
  comment.body = params[:body]
  comment.photo_id = params[:photo_id]
  comment.user_id = current_user.id
  comment.save

  redirect to "/photos/#{comment.photo_id}"
end

# User can delete a post if they wish
delete '/videos/:id/delete' do

  redirect to '/login/new' unless logged_in?

  video = Video.find_by(id: params[:id])
  comment = Comment.where(video_id: video.id)
  video.destroy

  redirect to '/'
end

delete '/photos/:id/delete' do

  redirect to '/login/new' unless logged_in?

  photo = Photo.find_by(id: params[:id])
  comment = Comment.where(photo_id: photo.id)
  photo.destroy

  redirect to '/'
end

# User profile pages used to display each users previous posts
get '/user_profile/:id' do
  redirect to '/login/new' unless logged_in?

  @user = User.find_by(id: params[:id])
  @user_photos = Photo.where(user_id: params[:id])
  @user_videos = Video.where(user_id: params[:id])

  erb :user_profile
end

# Login or sign up to start a new session
get '/login/new' do
  erb :login_new
end

# Grabs information for new users
post '/signup' do

  user = User.find_by(email: params[:email])

  # If the email does not exist, the new user is stored
  if user == nil

    user = User.new
    user.email = params[:email]
    user.username = params[:username]
    user.password = params[:password]

    # Are all fields populated
    if user.valid? == true
      user.save

      # Creates a new session if the password is equal user password input
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to '/'
      end

    else
      redirect to 'login/new'
    end

  else

    redirect to "/login/new"

  end
end


post '/session' do

  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect to '/'

  else

    erb :login_new

  end
end

# Removes the session
delete '/session' do
  session[:user_id] = nil
  redirect to '/login/new'
end
