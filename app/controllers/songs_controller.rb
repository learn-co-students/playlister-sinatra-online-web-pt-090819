class SongsController < ApplicationController
    require 'sinatra/base'
    #require 'rack-flash'

    get '/songs' do
        @songs = Song.all 
        erb :'songs/index'
    end
        
end