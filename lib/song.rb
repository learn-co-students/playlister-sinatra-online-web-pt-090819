class Song < ActiveRecord::Base
  has_one :artist
  belongs_to :genre
end