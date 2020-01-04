class Song_genre < ActveRecord::Base
    belongs_to :song 
    belongs_to :genre
end
