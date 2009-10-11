class DeckEditorController < ApplicationController
  layout nil

  def display
    render :action => 'editor'
  end
end
