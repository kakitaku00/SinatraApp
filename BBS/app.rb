require 'rubygems'
require 'bundler'

Bundler.require

set :database, {adapter: "sqlite3", database: "comments.sqlite3"}

class Comment < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :text
end

get '/' do
  @title = "BBS"
  # @comment = Comment.all
  erb :index
end

post '/creates' do
  puts ###### 以下データ ######
  p params

  name = params[:name]
  text = params[:text]

  comment = Comment.new({name: name, text: text})
  comment.save

  redirect '/'
end