require 'mysql2'
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

get '/' do
erb :add
end  

post '/add' do
task = params["item"]
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => '', :database => "todo")
results = client.query("insert into todolist(items,status) values('#{task}' , 'pending')")
erb:add
end
get '/pending' do   
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => '', :database => "todo")            
@tasks = client.query("select * from todolist where status='pending'")
erb:pending
end   

get '/completed' do
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => '', :database => "todo")            
@completed_tasks = client.query("select * from todolist where status='completed'")

erb:completed
end

get '/complete' do\
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => '', :database => "todo")
@tasks = client.query("select * from todolist where status='pending'")
erb:complete
end
post '/complete' do
n = params["item1"].to_i
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => '', :database => "todo")
results = client.query("update todolist set status='completed' where sl_no='#{n}'")
@tasks = client.query("select * from todolist where status='pending'")
erb:complete
end
get '/delete' do
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => '', :database => "todo")
@tasks = client.query("select * from todolist where status='completed'")
erb:delete
end
post '/delete' do
n1 = params["item2"].to_i
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => '', :database => "todo")            
@r = client.query("delete from todolist where sl_no='#{n1}'")
@tasks = client.query("select * from todolist where status='completed'")
erb:delete
end
