require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Run do

  it "should create a new run" do
    deck = Deck.create!({:name => "A deck"})
    card = Card.create!({:name => "A card"})
    Run.create!({:card => card, :deck => deck, :type => "a type", :count => 3})
  end
end
