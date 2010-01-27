require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DecksController do

  describe "rename" do

    before do
      session[:user] = Factory.create(:user).id
    end

    it "should rename the deck" do
      deck = Factory.create(:deck, :name => "Simple")
      new_name = "Complex"

      #post :rename, :deck_id => deck.id
      #Deck.find(deck.id).name.should == new_name
    end
  end
end
