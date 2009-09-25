require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/cards/new.html.erb" do
  include CardsHelper

  before(:each) do
    assigns[:card] = stub_model(Card,
      :new_record? => true,
      :name => "value for name",
      :type => "value for type",
      :mtg_id => "value for mtg_id"
    )
  end

  it "renders new card form" do
    render

    response.should have_tag("form[action=?][method=post]", cards_path) do
      with_tag("input#card_name[name=?]", "card[name]")
      with_tag("input#card_type[name=?]", "card[type]")
      with_tag("input#card_mtg_id[name=?]", "card[mtg_id]")
    end
  end
end
