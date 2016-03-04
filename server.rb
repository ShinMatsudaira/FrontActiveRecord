require 'sinatra'
require 'sinatra/reloader'
require 'slim'
require 'pry'
require 'date'
require_relative 'lib/front_active_record'
require_relative 'models/test'

Sinatra::Base.configure :development do
  register Sinatra::Reloader
end

get '/' do
  test = Test.new
  test.load
  @script = test.render
  slim :index
end



