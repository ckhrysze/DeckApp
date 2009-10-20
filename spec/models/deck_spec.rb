require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Deck do
  fixtures :cards, :runs

  it "should have cards through runs" do
    deck = Deck.create!({:name => "A Deck"})

    deck.cards = [
                  Card.create!({:name => "Card 1"}),
                  Card.create!({:name => "Card 2"}),
                  Card.create!({:name => "Card 3"}),
                  Card.create!({:name => "Card 4"})
                 ]
    deck.save.should == true
    deck.runs.size.should == 4
  end

  describe "cmc_values" do
    it "should count cmc for maindeck non lands" do
      deck = Deck.create!({:name => "Google Chart Test"})
      Run.create!(:pile => "maindeck", :deck => deck, :card => cards(:forest), :count => 20)
      Run.create!(:pile => "maindeck", :deck => deck, :card => cards(:ranger), :count => 4)
      Run.create!(:pile => "maindeck", :deck => deck, :card => cards(:draw), :count => 4)
      Run.create!(:pile => "maindeck", :deck => deck, :card => cards(:sprite), :count => 2)
      Run.create!(:pile => "maindeck", :deck => deck, :card => cards(:druid), :count => 4)
      Run.create!(:pile => "maindeck", :deck => deck, :card => cards(:stunt), :count => 3)
      deck.cmc_values.should == [8,2,4,0,3]
    end
  end

end
