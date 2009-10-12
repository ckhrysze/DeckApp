class Run < ActiveRecord::Base
  belongs_to :deck
  belongs_to :card

  module CardCountExtension
    def card_count
      loaded = false
      load_target
      proxy_target.map(&:count).sum
    end
  end

  named_scope :maindeck, :conditions => { "pile" => "maindeck" }, :extend => CardCountExtension
  named_scope :sideboard, :conditions => { "pile" => "sideboard" }, :extend => CardCountExtension
  named_scope :considering, :conditions => { "pile" => "considering" }, :extend => CardCountExtension

  named_scope :creature_runs, :joins => :card, :conditions => { "cards.cardtype" => "creature" }
  named_scope :land_runs, :joins => :card, :conditions => { "cards.cardtype" => "land" }
  named_scope :spell_runs, :joins => :card, :conditions => { "cards.cardtype" => "spell" }

  def self.creatures
    Card.by_runs(creature_runs)
  end

  def self.lands
    Card.by_runs(land_runs)
  end

  def self.spells
    Card.by_runs(spell_runs)
  end

end
