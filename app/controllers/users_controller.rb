class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
          erb :"users/signup"
        else
          redirect "index"
        end
    end

    post "/signup" do
      user = User.new(params[:user])
      if user.save
        session[:user_id] = user.id
        redirect "/"
      else
        redirect "users/signup"
      end
    end

    get '/login' do
      if !logged_in?
        erb :"users/login"
      else
        redirect "/"
      end
    end

    post "/login" do
      binding.pry
      user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
        else
        redirect "/login"
      end
    end

    get "/logout" do
      session.clear
      redirect "/"
    end

end