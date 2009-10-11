ActionController::Routing::Routes.draw do |map|
  map.resources :cards

  map.resources :decks do |decks|
    decks.resources :runs
  end 

  # The priority is based upon order of creation: first created -> highest priority.

  map.connect 'editor', :controller => 'deck_editor', :action => 'display'

  map.connect ':controller/:action.:format'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
