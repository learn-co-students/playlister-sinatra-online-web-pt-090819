class ArtistsController < ApplicationController

    get '/artist' do
        @artists = Artist.all
        erb :'artists/index'
    end
end
