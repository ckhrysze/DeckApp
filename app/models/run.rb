class Run < ActiveRecord::Base
  belongs_to :deck
  belongs_to :card

  module CardCountExtension
    def card_count
      reset             # to force load_target to load the correct data
      load_target       # since the proxy_target doesn't eager load
      proxy_target.map(&:count).sum
    end
  end

  named_scope :maindeck, :conditions => { "pile" => "maindeck" }, :extend => CardCountExtension
  named_scope :sideboard, :conditions => { "pile" => "sideboard" }, :extend => CardCountExtension
  named_scope :considering, :conditions => { "pile" => "considering" }, :extend => CardCountExtension

  named_scope :lands, :joins => :card, :conditions => { "cards.cardtype" => "land" }
  named_scope :creatures, :joins => :card, :conditions => { "cards.cardtype" => "creature" }
  named_scope :spells, :joins => :card, :conditions => { "cards.cardtype" => "spell" }
  named_scope :nonlands, :joins => :card, :conditions => { "cards.cardtype" => ["spell", "creature"] }
  named_scope :unknown, :joins => :card, :conditions => { "cards.mtg_id" => nil }


  def name
    card.name
  end

  def cardtype
    card.cardtype
  end

  def mtg_id
    card.mtg_id
  end  

  def cc
    card.cc
  end

  def cmc
    card.cmc
  end
end
