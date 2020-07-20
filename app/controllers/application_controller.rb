require './config/environment'

binding.pry

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "DkKU2qdWC7eYhhSDBhufAbWnYpSHN2avAavh874sh56vSCG8Sg38YycRCUkbtvU8"
  end

  get "/" do
      erb :index
  end

  helpers do
    def logged_in?
			!!session[:user_id]
		end

    def current_user
      !!session[:user_id] ? User.find(session[:user_id]) : nil
		end
  end

end
