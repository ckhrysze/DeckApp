class Deck < ActiveRecord::Base
  has_many :runs
  has_many :cards, :through => :runs

  def maindeck
    runs.maindeck
  end
end
