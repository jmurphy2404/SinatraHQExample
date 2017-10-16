require 'sinatra'
require 'sinatra/activerecord'
require 'sqlite3'
require './models'
require 'sinatra/flash'

enable :sessions

set :database, {adapter: 'sqlite3', database: 'hq.sqlite3'}

before do
	current_user
end

#login protection
before ['/questions/new','/questions'] do
	redirect '/' unless @current_user
end

get '/' do
	@questions = Question.all
	erb :home
end

get '/questions/new' do
	erb :new_question
end

post '/questions' do
	accepted_keys = %w(body option1 option2 option3 correct_answer)	
	question = Question.new params.select{|k| accepted_keys.include? k}
#one way
	# question = Question.new {
	# 	body: params[:body],
	# 	option1: params[:option1],
	# 	option2: params[:option2],
	# 	option3: params[:option3],
	# 	correct_answer: params[:correct_answer]
	# }
	question.save
	redirect '/'
end

#handle login
post '/login' do
	user = User.find_by(slack: params[:slack])
	if user && user.password == params[:password]
		session[:user_id] = user.id
		flash[:message] = "Welcome, nerd."
		redirect '/'
	else
		flash[:message] = "Ooops, did you forget your account information?  I don't recognize that user/pass combo, you nerd."
		redirect back
	end
end

get '/logout' do
	session[:user_id] = nil
	flash[:message] = "You're logged out. NERD!"
	redirect '/'
end

def current_user
	@current_user = User.find(session[:user_id])if session[:user_id]
end