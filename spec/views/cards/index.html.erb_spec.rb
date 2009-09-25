require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/cards/index.html.erb" do
  include CardsHelper

  before(:each) do
    assigns[:cards] = [
      stub_model(Card,
        :name => "value for name",
        :type => "value for type",
        :mtg_id => "value for mtg_id"
      ),
      stub_model(Card,
        :name => "value for name",
        :type => "value for type",
        :mtg_id => "value for mtg_id"
      )
    ]
  end

  it "renders a list of cards" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for type".to_s, 2)
    response.should have_tag("tr>td", "value for mtg_id".to_s, 2)
  end
end
