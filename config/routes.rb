ActionController::Routing::Routes.draw do |map|
  map.resources :cards

  map.resources :decks, :member => { :rename => :post } do |decks|
    decks.resources :runs
  end

  map.with_options(:controller => 'decks') do |decks|
    decks.connect 'decks/:id/mana_curve_chart', :action => 'mana_curve_chart'
  end

  map.login "login", :controller => :rpx, :action => :index
  map.connect "logout", :controller => :rpx, :action => :logout

  map.root :controller => "landing"
end
