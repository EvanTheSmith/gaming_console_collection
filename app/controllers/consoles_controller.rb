class ConsolesController < ApplicationController

    get '/consoles' do
        @consoles = Console.all.sort_by {|obj| obj.name}
        erb :"consoles/index"
    end

    post '/consoles' do
        console = Console.new(params[:console])
        console.user = current_user
        if console.save
            flash[:success] = "Successfully added #{console.name} to your collection."
            redirect "/consoles/#{console.id}"
        else
            flash[:fail] = "Adding console failed! Please try again."
            redirect "/consoles/new"
        end
    end

    delete '/consoles/:id' do
        console = Console.find(params[:id])
        console.destroy
        flash[:success] = "Console deleted."
        redirect "/users/#{current_user.slug}"
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

    patch '/consoles/:id' do
        console = Console.find(params[:id])
        console.update(params[:console])
        if console.save
          flash[:success] = "Successfully edited #{console.name}."
          redirect "/consoles/#{console.id}"
        else
          flash[:fail] = "Editing console failed! Please try again."
          redirect "/consoles/#{console.id}/edit"
        end
    end

end