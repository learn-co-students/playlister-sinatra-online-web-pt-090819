require 'sinatra/base'
require 'rack-flash'

class SongsController < ApplicationController
    enable :sessions
    use Rack::Flash
    register Sinatra::ActiveRecordExtension
    set :session_secret, "my_application_secret"
    set :views, Proc.new { File.join(root, "../views/") }

    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end

    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end

    post '/songs' do
        @song = Song.create(:name => params[:song][:name])
        
        #artist = Artist.find_or_create(params[:song][:artist])
        artist_entry = params[:song][:artist]
        if Artist.find_by(:name => artist_entry)
            artist = Artist.find_by(:name => artist_entry)
        else
            artist = Artist.create(:name => artist_entry)
        end
        @song.artist = artist

        genre_selections = params[:song][:genres]
        
        genre_selections.each do |genre|
            @song.genres << Genre.find(genre)
            
        end

        @song.save
        # binding.pry
        flash[:message] = "Successfully created song."
        redirect to "songs/#{@song.slug}"

    end

    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/show'
    end

    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        erb :'songs/edit'
    end

    patch '/songs/:slug' do
        # binding.pry
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.save
    
        flash[:message] = "Successfully updated song."
        redirect to "/songs/#{@song.slug}"
        

    end


    
end
