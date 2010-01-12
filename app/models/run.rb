class Run
  include MongoMapper::EmbeddedDocument

  key :count, Integer
  key :card, Mongo::ObjectID

  delegate :cardtype, :name, :cmc,
  :to => :card

end
