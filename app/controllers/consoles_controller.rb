class ConsolesController < ApplicationController

    get '/consoles' do
        @consoles = Console.all
        erb :"consoles/index"
    end

    post '/consoles' do
        console = Console.new(params[:console])
        console.user = current_user
        if console.save
            redirect "/consoles/#{console.id}"
        else
            redirect "/consoles/new"
        end
    end

    get '/consoles/new' do
        if logged_in?
        erb :"consoles/new"
        else
        redirect "/login"
        end
    end

    get '/consoles/:id' do
        @console = Console.find(params[:id])
        erb :"consoles/show"
    end

end