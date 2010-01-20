require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
#require File.expand_path(Rails.root + 'spec/spec_helper')


describe RunsController do

  describe "create" do
#    it "should create a new card if no card exists with the given name" do
#      print "(#{Card.all.size})"
#      deck = Factory.create(:deck)
#      card_name = "asdf"
#
#      Card.find_all_by_name(card_name).size.should == 0
#      post :create, :deck_id => deck.id, :card_name => card_name
#      Card.find_all_by_name(card_name).size.should == 1
#      print "(#{Card.all.size})"
#    end
#
    it "should default count to 1" do
      deck = Factory.create(:deck)
      card = Factory.create(:card)

      post :create, :deck_id => deck.id, :card_name => card.name
      deck = Deck.find(deck.id)
      deck.maindeck.runs.first.count.should == 1
    end

    it "should not create a new card when one exists with the given name" do
      deck = Factory.create(:deck)
      card = Factory.create(:card)

      Card.find_all_by_name(card.name).size.should == 1
      post :create, :deck_id => deck.id, :card_name => card.name
      Card.find_all_by_name(card.name).size.should == 1
    end

    it "should bump count when a run of the given deck and pile already exists" do
      deck = Factory.create(:deck)
      card = Factory.create(:card)
      deck.maindeck.runs << Factory.create(:run, :card => card, :count => 5)
      deck.save

      post :create, :deck_id => deck.id, :card_name => card.name
      deck = Deck.find(deck.id)
      deck.maindeck.runs.first.count.should == 6
    end
    
    it "should append a new run when one doesn't exist in the deck's given pile" do
    end


    #it "should create new run when pile is the only difference" do
  end
end
