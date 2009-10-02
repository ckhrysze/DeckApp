class AddDeckCardJoins < ActiveRecord::Migration
  def self.up
    create_table :maindecks do |t|
      t.integer :card_id
      t.integer :deck_id
      t.integer :count
    end
    create_table :sideboards do |t|
      t.integer :card_id
      t.integer :deck_id
      t.integer :count
    end
  end

  def self.down
    drop_table :maindecks
    drop_table :sideboards
  end
end
