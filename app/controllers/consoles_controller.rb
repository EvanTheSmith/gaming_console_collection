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

    delete '/consoles/:id' do
        if logged_in?
            console = Console.find(params[:id])
            if console.user == current_user
              console.destroy
              redirect "/users/#{current_user.slug}"
            else
              redirect "/consoles"
            end
        else
            redirect "/login"
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

    get '/consoles/:id/edit' do
        if logged_in?
            @console = Console.find(params[:id])
            if current_user == @console.user
                erb :"consoles/edit"
            else
                redirect "/consoles"
            end
        else
            redirect "/login"
        end
    end

    patch '/tweets/:id' do
        @console = Console.find(params[:id])
        @console.update(content: params[:console])
    
        if @console.save
          redirect "/consoles/#{@console.id}"
        else
          redirect "/tweets/#{@console.id}/edit"
        end
    end

end