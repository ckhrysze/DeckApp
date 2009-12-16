class User < ActiveRecord::Base

  has_many :decks
  has_many :identifiers

end
