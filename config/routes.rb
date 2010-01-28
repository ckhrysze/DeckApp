ActionController::Routing::Routes.draw do |map|
  map.resources :cards

  map.resources :decks, :member => { :count => :get, :rename => :post } do |decks|
    decks.resources :runs
  end

  map.with_options(:controller => 'decks') do |decks|
    decks.connect 'decks/:id/mana_curve_chart', :action => 'mana_curve_chart'
  end

  map.login "login", :controller => :rpx, :action => :index
  map.logout "logout", :controller => :rpx, :action => :logout

  map.connect "tools", :controller => :landing, :action => :tools
  map.connect "about", :controller => :landing, :action => :about

  map.root :controller => "landing"
end
