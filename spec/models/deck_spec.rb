require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Deck do
  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Deck.create!(@valid_attributes)
  end

  it "should allow cards to be added" do
    deck = Deck.create!({:name => "A Deck"})
    deck.cards = [
                  Card.create!({:name => "Card 1"}),
                  Card.create!({:name => "Card 2"}),
                  Card.create!({:name => "Card 3"}),
                  Card.create!({:name => "Card 4"})
                 ]
    deck.save.should == true
  end
end
