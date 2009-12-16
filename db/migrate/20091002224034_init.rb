class Init < ActiveRecord::Migration
  def self.up

    create_table :users do |t|
      t.string :display_name
    end

    create_table :identifiers do |t|
      t.string :provider
      t.string :ident
      t.timestamps
    end

    create_table :decks do |t|
      t.string :name
      t.timestamps
    end

    create_table :cards do |t|
      t.string  :name
      t.string  :cardtype
      t.string  :mtg_id
      t.string  :cc
      t.integer :cmc
      t.timestamps
    end

    create_table :runs do |t|
      t.integer :card_id
      t.integer :deck_id
      t.integer :count
      t.string  :pile
    end
  end

  def self.down
    drop_table :users
    drop_table :identifiers
    drop_table :cards
    drop_table :decks
    drop_table :runs
  end
end
