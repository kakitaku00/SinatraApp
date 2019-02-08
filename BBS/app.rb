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
  @comment = Comment.new
  @comments = Comment.all
  erb :index
end

post '/creates' do

  @comments = Comment.all

  name = params[:name]
  text = params[:text]

  @comment = Comment.new({name: name, text: text})
  if @comment.save {
    redirect '/'
  }
  else
    erb :index
  end
end

delete '/destroy' do
  @comment = Comment.find(params[:id])
  @comment.destroy
  redirect '/'
end