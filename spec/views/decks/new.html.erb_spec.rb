require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/decks/new.html.erb" do
  include DecksHelper

  before(:each) do
    assigns[:deck] = stub_model(Deck,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new deck form" do
    render

    response.should have_tag("form[action=?][method=post]", decks_path) do
      with_tag("input#deck_name[name=?]", "deck[name]")
    end
  end
end
