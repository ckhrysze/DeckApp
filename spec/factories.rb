# Cards
Factory.define :card do |c|
  c.name "Sample Card"
  c.sequence(:mtg_id) {|n| "magic_id_#{n}" }
end

Factory.define :land, :parent => :card do |c|
  c.cmc 0  
  c.cardtype "land"
end

Factory.define :creature, :parent => :card do |c|
  c.cmc 1
  c.cardtype "creature"
end

Factory.define :spell, :parent => :card do |c|
  c.cmc 1
  c.cardtype "spell"
end

# Runs
Factory.define :run do |r|
  r.count 0
  r.card Factory.create(:card)
end

# Decks
Factory.define :deck do |d|
  d.name "A Deck"
end

# Users
Factory.define :user do |u|
  u.nick "asdf"
end
