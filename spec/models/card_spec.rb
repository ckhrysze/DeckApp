require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Card do
  before(:each) do
    @valid_attributes = {
      :name => "value for name",
      :type => "value for type",
      :mtg_id => "value for mtg_id"
    }
  end

  it "should create a new instance given valid attributes" do
    Card.create!(@valid_attributes)
  end
end
