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
        if usertest = User.all.find {|user| user.user_name.downcase == params[:user][:user_name].downcase} || User.all.find {|user| user.email.downcase == params[:user][:email].downcase}
        @username = usertest.user_name
        erb :"users/login"
        else
        redirect "/signup"
        end
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
      user = User.find {|user| user.user_name.downcase == params[:user_name].downcase }
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:notice] = "Login successful!"
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