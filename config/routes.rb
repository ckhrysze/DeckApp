ActionController::Routing::Routes.draw do |map|
  map.resources :cards

  map.resources :decks do |decks|
    decks.resources :runs
  end

  map.with_options(:controller => 'decks') do |decks|
    decks.connect 'decks/:id/mana_curve_chart', :action => 'mana_curve_chart'
  end

  map.root :controller => "landing"
end
