class CardDeckJoin < ActiveRecord::Migration

  def self.up
    create_table :cards_decks, :id => false do |t|
      t.integer :card_id
      t.integer :deckpart_id
    end
    add_column :decks, :card_id, :int
    add_column :cards, :deck_id, :int
  end

  def self.down
    drop_table :cards_decks
    remove_column :decks, :card_id
    remove_column :cards, :deck_id
  end
end
