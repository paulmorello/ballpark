require 'sinatra'
require 'sinatra/reloader'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
# require 'image_magick'
require_relative 'db_config'
require_relative 'models/video'
require_relative 'models/my_uploader'
require_relative 'models/photo'
require_relative 'models/user'
require_relative 'models/sport'
require_relative 'models/comment'
require 'pry'

enable :sessions

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

  @videos = Video.all
  @photos = Photo.all.reverse_order
  @posts = Photo.where(sport_id: 1)
  erb :index
end

get '/videos/new' do

  redirect to '/login/new' unless logged_in?

  @sports = Sport.all

  erb :videos_new

end

post '/videos' do

  video = Video.new
  video.title = params[:title]
  video.sport_id = params[:sport_id]
  video.description = params[:description]
  video.video_url = params[:video_url]
  video.user_id = current_user.id
  video.save

  redirect to '/'

end

get '/photos/new' do

  redirect to '/login/new' unless logged_in?

  @sports = Sport.all

  erb :photos_new

end

post '/photos' do

  photo = Photo.new
  photo.title = params[:title]
  photo.sport_id = params[:sport_id]
  photo.description = params[:description]
  photo.photo_url = params[:photo_url]
  photo.user_id = current_user.id
  photo.save

  redirect to '/'

end

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

post '/videos/:id' do

  video = Video.find_by(id: params[:id])
  video.update(title: params[:title], sport_id: params[:sport_id], description: params[:description], video_url: params[:video_url])

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
  photo.update(title: params[:title], sport_id: params[:sport_id], description: params[:description], photo_url: params[:photo_url])

  redirect to "/photos/#{params[:id]}"

end

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

delete '/videos/:id/delete' do

  redirect to '/login/new' unless logged_in?

  video = Video.find_by(id: params[:id])
  comment = Comment.where(video_id: video.id)
  comment.destroy
  video.destroy

  redirect to '/'
end

delete '/photos/:id/delete' do

  redirect to '/login/new' unless logged_in?

  photo = Photo.find_by(id: params[:id])
  comment = Comment.where(photo_id: photo.id)
  comment.destroy
  photo.destroy

  redirect to '/'
end

get '/user_profile/:id' do
  redirect to '/login/new' unless logged_in?

  @user = User.find_by(id: params[:id])
  @user_photos = Photo.where(user_id: params[:id])
  @user_videos = Video.where(user_id: params[:id])

  erb :user_profile
end

get '/login/new' do
  erb :login_new
end

post '/signup' do

  user = User.find_by(email: params[:email])

  if user == nil

    user = User.new
    user.email = params[:email]
    user.username = params[:username]
    user.password = params[:password]

    if user.valid? == true
      user.save
      if user && user.authenticate(params[:password])
        # you are fine, let me create a session for you
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
    # you are fine, let me create a session for you
    session[:user_id] = user.id
    redirect to '/'
  else
    # who are you
    erb :login_new
  end
end

delete '/session' do
  #remove the session
  session[:user_id] = nil
  redirect to '/login/new'
end
