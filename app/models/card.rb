class Card < ActiveRecord::Base

  named_scope :land, :conditions => { "cardtype" => "land" }

  named_scope :by_runs, lambda { |runs|
    card_ids = runs.map(&:card_id)
    {:conditions => ['id in (?)', card_ids]}
  }

  def sync_with_gatherer()
    self.mtg_id = Gatherer.retrieve_mtg_id(name).to_i
    save()
    self
  end
end
