require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require_relative 'models/video'
require_relative 'models/photo'
require_relative 'models/user'
require_relative 'models/sport'
require_relative 'models/comment'
require 'pry'

get '/' do

  @videos = Video.all
  @photos = Photo.all
  erb :index
end

get '/videos/new' do

  # redirect to '/session/new' unless logged_in?

  @sports = Sport.all

  erb :videos_new

end

post '/videos' do

  video = Video.new
  video.title = params[:title]
  video.sport_id = params[:sport_id]
  video.description = params[:description]
  video.video_url = params[:video_url]
  video.save

  redirect to '/'

end

get '/photos/new' do

  # redirect to '/session/new' unless logged_in?

  @sports = Sport.all

  erb :photos_new

end

post '/photos' do

  photo = Photo.new
  photo.title = params[:title]
  photo.sport_id = params[:sport_id]
  photo.description = params[:description]
  photo.photo_url = params[:photo_url]
  photo.save

  redirect to '/'

end

get '/videos/:id' do

  @video = Video.find_by(id: params[:id])

  @comments = Comment.where( video_id: @video.id )

  erb :video_show

end

get '/photos/:id' do

  @photo = Photo.find_by(id: params[:id])

  @comments = Comment.where( photo_id: @photo.id )

  erb :photo_show

end

get '/videos/:id/edit' do

  @video = Video.find_by(id: params[:id])
  @sports = Sport.all

  erb :video_edit
end

post '/videos/:id' do

  video = Video.find_by(id: params[:id])
  video.update(title: params[:title], sport_id: params[:sport_id], description: params[:description], video_url: params[:video_url])

  redirect to "/videos/#{params[:id]}"

end

get '/photos/:id/edit' do

  @photo = Photo.find_by(id: params[:id])
  @sports = Sport.all

  erb :photo_edit
end

post '/photos/:id' do

  photo = Photo.find_by(id: params[:id])
  photo.update(title: params[:title], sport_id: params[:sport_id], description: params[:description], photo_url: params[:photo_url])

  redirect to "/photos/#{params[:id]}"

end

post '/comments/video' do
  comment = Comment.new
  comment.body = params[:body]
  comment.video_id = params[:video_id]
  comment.save

  redirect to "/videos/#{comment.video_id}"

end

post '/comments/photo' do
  comment = Comment.new
  comment.body = params[:body]
  comment.photo_id = params[:photo_id]
  comment.save

  redirect to "/photos/#{comment.photo_id}"

end

delete '/videos/:id/delete' do

  video = Video.find_by(id: params[:id])
  video.destroy

  redirect to '/'
end

delete '/photos/:id/delete' do

  photo = Photo.find_by(id: params[:id])
  photo.destroy

  redirect to '/'
end



# SELECT column_name(s)
# FROM table1
# JOIN table2
# ON table1.column_name=table2.column_name;
