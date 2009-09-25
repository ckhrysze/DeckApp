require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/cards/show.html.erb" do
  include CardsHelper
  before(:each) do
    assigns[:card] = @card = stub_model(Card,
      :name => "value for name",
      :type => "value for type",
      :mtg_id => "value for mtg_id"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ type/)
    response.should have_text(/value\ for\ mtg_id/)
  end
end
