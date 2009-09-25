require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DecksController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "decks", :action => "index").should == "/decks"
    end

    it "maps #new" do
      route_for(:controller => "decks", :action => "new").should == "/decks/new"
    end

    it "maps #show" do
      route_for(:controller => "decks", :action => "show", :id => "1").should == "/decks/1"
    end

    it "maps #edit" do
      route_for(:controller => "decks", :action => "edit", :id => "1").should == "/decks/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "decks", :action => "create").should == {:path => "/decks", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "decks", :action => "update", :id => "1").should == {:path =>"/decks/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "decks", :action => "destroy", :id => "1").should == {:path =>"/decks/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/decks").should == {:controller => "decks", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/decks/new").should == {:controller => "decks", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/decks").should == {:controller => "decks", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/decks/1").should == {:controller => "decks", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/decks/1/edit").should == {:controller => "decks", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/decks/1").should == {:controller => "decks", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/decks/1").should == {:controller => "decks", :action => "destroy", :id => "1"}
    end
  end
end
