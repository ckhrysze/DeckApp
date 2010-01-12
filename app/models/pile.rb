class Pile
  include MongoMapper::EmbeddedDocument

  key :name, String
  many :runs


  def <<(run)
    self.runs << run
  end

  def nonlands
    self.runs.select { |r| r.cardtype != 'land' }
  end

  def lands
    self.runs.select { |r| r.cardtype == 'land' }
  end

  def creatures
    self.runs.select { |r| r.cardtype == 'craeture' }
  end

  def spells
    self.runs.select { |r| r.cardtype == 'spell' }
  end

  def unknown
    self.runs.select { |r| r.cardtype.blank? }
  end

end
