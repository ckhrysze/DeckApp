class Deck < ActiveRecord::Base
  has_many :runs
  has_many :cards, :through => :runs

  def maindeck
    runs.maindeck(true)
  end
  def sideboard
    runs.sideboard(true)
  end
  def considering
    runs.considering(true)
  end
end
