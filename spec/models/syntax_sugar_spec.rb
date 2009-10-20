require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# Chris wants certain things to work, and this just makes
# sure they do
describe "Syntax Sugar" do

  before(:each) do
    @forest =   Card.create!({:name => "Forest", :cardtype => "land", :cc => nil, :cmc => nil})
    @mountain = Card.create!({:name => "Mountain", :cardtype => "land", :cc => nil, :cmc => nil})
    @swamp =    Card.create!({:name => "Swamp", :cardtype => "land", :cc => nil, :cmc => nil})
    @island =   Card.create!({:name => "Island", :cardtype => "land", :cc => nil, :cmc => nil})
    @plains =   Card.create!({:name => "Plains", :cardtype => "land", :cc => nil, :cmc => nil})

    @ranger =   Card.create!({:name => "Scryb Ranger", :cardtype => "creature", :cc => "G", :cmc => 1})
    @sprite =   Card.create!({:name => "Scryb Sprites", :cardtype => "creature", :cc => "1G", :cmc => 2})
    @knight =   Card.create!({:name => "white Knight", :cardtype => "creature", :cc => "WW", :cmc => 2})
    @rat =      Card.create!({:name => "Raveneous Rats", :cardtype => "creature", :cc => "1B", :cmc => 2})
    @wall =     Card.create!({:name => "Wall of Blossoms", :cardtype => "creature", :cc => "1G", :cmc => 2})

    @tangle =   Card.create!({:name => "Tangle", :cardtype => "spell", :cc => "1G", :cmc => 2})
    @counter =  Card.create!({:name => "Counter Spell", :cardtype => "spell", :cc => "UU", :cmc => 2})
    @stunt =    Card.create!({:name => "Stunted Growth", :cardtype => "spell", :cc => "3GG", :cmc => 5})
    @draw =     Card.create!({:name => "Brainstorm", :cardtype => "spell", :cc => "U", :cmc => 1})
    @darkrit =  Card.create!({:name => "Dark Ritual", :cardtype => "spell", :cc => "B", :cmc => 1})

    @deck = Deck.create!({:name => "syntax sugar deck"})

    Run.create!({:deck => @deck, :card => @forest, :count => 6, :pile => "maindeck"})
    Run.create!({:deck => @deck, :card => @island, :count => 6, :pile => "maindeck"})
    Run.create!({:deck => @deck, :card => @counter, :count => 4, :pile => "maindeck"})
    Run.create!({:deck => @deck, :card => @ranger, :count => 4, :pile => "maindeck"})
    Run.create!({:deck => @deck, :card => @sprite, :count => 4, :pile => "maindeck"})
    Run.create!({:deck => @deck, :card => @draw, :count => 4, :pile => "maindeck"})

    Run.create!({:deck => @deck, :card => @swamp, :count => 6, :pile => "sideboard"})
    Run.create!({:deck => @deck, :card => @rat, :count => 4, :pile => "sideboard"})
    Run.create!({:deck => @deck, :card => @darkrit, :count => 4, :pile => "sideboard"})

    Run.create!({:deck => @deck, :card => @wall, :count => 4, :pile => "considering"})
    Run.create!({:deck => @deck, :card => @stunt, :count => 4, :pile => "considering"})
    Run.create!({:deck => @deck, :card => @tangle, :count => 4, :pile => "considering"})
  end

  it "should find piles from deck" do
    @deck.maindeck.count.should == 6
    @deck.sideboard.count.should == 3
    @deck.considering.count.should == 3
  end

  # doing these in one method turned out to catch
  # a rather interesting error, apparently the
  # extension in run's named_scopes will only
  # reload after reset is called
  it "should count piles from deck" do
    @deck.maindeck.card_count.should == 28
    @deck.sideboard.card_count.should == 14
    @deck.considering.card_count.should == 12
  end

  it "should count maindeck pile" do
    @deck.maindeck.card_count.should == 28
  end

  it "should count sideboard pile" do
    @deck.sideboard.card_count.should == 14
  end

  it "should count considering pile" do
    @deck.considering.card_count.should == 12
  end

  it "should find cards by type from a pile collection" do
    @deck.maindeck.spells.count.should == 2
    @deck.maindeck.creatures.count.should == 2
    @deck.maindeck.lands.count.should == 2
    @deck.maindeck.nonlands.count.should == 4
  end
end
