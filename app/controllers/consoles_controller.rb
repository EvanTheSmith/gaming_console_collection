class ConsolesController < ApplicationController

    get "/consoles" do
        @consoles = Console.all
        erb :"consoles/index"
    end

    get '/consoles/:id' do
        @console = Console.find(params[:id])
        erb :"consoles/show"
    end

end