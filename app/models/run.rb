class Run
  include MongoMapper::EmbeddedDocument

  key :count, Integer
  key :card_id, Mongo::ObjectID

  belongs_to :card

  delegate :cardtype, :name, :cmc, :cc, :mtg_id, :to => :card

end
