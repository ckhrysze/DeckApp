require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Deck do
  describe "cmc_values" do
    it "should count cmc for maindeck non lands" do
      deck = Deck.create!({:name => "Google Chart Test"})
      deck.maindeck << make_run(:land, 20)
      deck.maindeck << make_run(:creature, 4, 1)
      deck.maindeck << make_run(:spell, 4, 1)
      deck.maindeck << make_run(:creature, 2, 2)
      deck.maindeck << make_run(:creature, 4, 3)
      deck.maindeck << make_run(:spell, 3, 5)
      deck.cmc_values.should == [8,2,4,0,3]
    end
  end

  def make_run(card_type_sym, count = 1, cmc = 0)
    Factory.create(:run, :count => count, :card => Factory.create(card_type_sym, :cmc => cmc))
  end
end
