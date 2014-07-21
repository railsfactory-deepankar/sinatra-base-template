require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require './todo.rb'
t = Todolist.new("deep.txt")
configure do
  set :views, "#{File.dirname(__FILE__)}/views"
end

enable :sessions
set :session_secret, 'randomesecretkey112324'

# root page
get '/' do
erb :add
end  

post '/add' do
task = params["item"]
t.add(task)
t.list
t.save
erb:add
end
get '/pending' do               
@tasks = t.pending
erb:pending
end   

get '/completed' do
@completed_tasks = t.completed
erb:completed
end

get '/complete' do
@tasks = t.pending 
erb:complete
end
post '/complete' do
n = params["item1"].to_i
if n != 0
t.complete(n)
t.list
t.save
@tasks = t.pending
erb:complete
end
end
get '/delete' do
@tasks = t.completed
erb:delete
end
post '/delete' do
n1 = params["item2"].to_i
t.delete(n1)
t.list
t.save
@tasks = t.completed
erb:delete
end
