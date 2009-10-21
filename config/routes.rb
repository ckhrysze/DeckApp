ActionController::Routing::Routes.draw do |map|
  map.resources :cards

  map.resources :decks do |decks|
    decks.resources :runs
  end

  map.with_options(:controller => 'decks') do |decks|
    decks.connect 'decks/:id/mana_curve_chart', :action => 'mana_curve_chart'
  end

  # The priority is based upon order of creation: first created -> highest priority.

  #map.connect 'auth/:action', :controller => 'auth'

  # map.connect ':controller/:action.:format'
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
