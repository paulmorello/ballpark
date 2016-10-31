require 'sinatra'
require 'sinatra/reloader'
require_relative 'db_config'
require 'pry'

get '/' do

  erb :index
end
