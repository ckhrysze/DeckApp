require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RunsController do

  def mock_card(stubs={})
    @mock_card ||= mock_model(Card, stubs)
  end

  def mock_deck(stubs={})
    @mock_deck ||= mock_model(Deck, stubs)
  end

  describe "create" do
    it "should bump count when a run of the given card, deck, and type already exists" do

    end
  
    it "should create new run when type is the only difference" do

    end
  end
end
