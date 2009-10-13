class RunsController < ApplicationController
  layout nil

  def index
    @runs = Deck.find(params[:deck_id]).runs

    respond_to do |format|
      format.xml  { render :xml => @runs }
    end
  end

  def create
    card_name = params[:card_name]
    deck = Deck.find(params[:deck_id])
    count = params[:count].to_i
    pile = "maindeck"

    card = Card.find_or_create_by_name(card_name)

    runs = Run.find(:all, :conditions => {:deck_id => deck.id, :card_id => card.id, :pile => pile})
    raise "found multiple runs of the same card and pile" if runs.length > 1

    @run = runs.first unless runs.empty?
    @run ||= Run.create({:deck => deck, :card => card, :pile => pile, :count => 0})
    @run.count += count
    @run.save

    respond_to do |format|
      format.xml  { render :xml => @run.to_json( :include => :card ) }
      format.json  { render :xml => @run.to_json( :include => :card ) }
    end
  end

  def show
    @run = Run.find(params[:id])
    respond_to do |format|
      format.xml  { render :xml => @run.to_xml( :include => :card ) }
    end
  end

  def destroy
    @run = Run.find(params[:id])
    @run.destroy
  end
end
