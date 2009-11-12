class Card < ActiveRecord::Base

  named_scope :lands, :conditions => { "cardtype" => "land" }
  named_scope :creatures, :conditions => { "cardtype" => "creature" }
  named_scope :spells, :conditions => { "cardtype" => "spell" }

  def after_create
    sync_with_gatherer
  end

  def sync_with_gatherer()
    return self if synced

    RAILS_DEFAULT_LOGGER.info("Attempting to sync #{name}")
    gatherer_info = Gatherer.retrieve_gatherer_info(name.gsub(" ", "%20"))
    self.mtg_id = gatherer_info[:mtg_id]
    self.cc = gatherer_info[:cc]
    self.cmc = gatherer_info[:cmc]
    self.cardtype = gatherer_info[:cardtype]
    save()
    self
  end

  def synced
    return !mtg_id.nil?
  end
end
