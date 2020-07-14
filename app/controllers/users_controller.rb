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
        redirect "/signup"
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
      user = User.find_by(user_name: params[:user_name])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/#{current_user.slug}"
        else
        redirect "/login"
      end
    end

    get "/logout" do
      session.clear
      redirect "/"
    end

    get "/users" do
      @users = User.all
      erb :"users/index"
    end

    get "/users/:slug" do
      @user = User.find_by_slug(params[:slug])
      erb :"users/show"
    end

end