require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/decks/edit.html.erb" do
  include DecksHelper

  before(:each) do
    assigns[:deck] = @deck = stub_model(Deck,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit deck form" do
    render

    response.should have_tag("form[action=#{deck_path(@deck)}][method=post]") do
      with_tag('input#deck_name[name=?]', "deck[name]")
    end
  end
end
