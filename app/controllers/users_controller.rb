class UsersController < ApplicationController

    get '/signup' do
        if !logged_in?
          erb :"users/signup"
        else
          redirect "/"
        end
    end

    post "/signup" do
      user = User.new(params[:user])
      if user.save
        session[:user_id] = user.id
        flash[:success] = "Account successfully created: #{user.user_name}"
        redirect "/"
      else
        if usertest = User.all.find {|user| user.user_name.downcase == params[:user][:user_name].downcase} || User.all.find {|user| user.email.downcase == params[:user][:email].downcase}
        session[:login] = usertest.user_name
        flash[:fail] = "Your email or username is already in use. Did you mean to login?"
        redirect "/login"
        else
        flash[:fail] = "Sign up failed! Please try again."
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
        flash[:success] = "Login successful."
        session[:login].clear if session[:login]
        redirect "/users/#{current_user.slug}"
        else
        flash[:fail] = "Login failed! Please try again."
        redirect "/login"
      end
    end

    get "/logout" do
      session.clear
      flash[:success] = "Logout successful."
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