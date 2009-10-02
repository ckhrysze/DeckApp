class Deck < ActiveRecord::Base
  has_many :maindecks
  has_many :cards, :through => :maindecks

  has_many :sideboards
  has_many :sideboard_cards, :through => :sideboards, :source => :card
end
