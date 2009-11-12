class DecksController < ApplicationController

  def mana_curve_chart
    @deck = Deck.find(params[:id])
    render :json => {:src => @deck.mana_curve_chart, :alt => "mana curve chart"}.to_json
  end

  def blah
  end

  def index
    @decks = Deck.all

    respond_to do |format|
      format.html { render :layout => 'application' }
      format.xml  { render :xml => @decks }
    end
  end

  def show
    @deck = Deck.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @deck }
    end
  end

  def new
    @deck = Deck.new

    respond_to do |format|
      format.html { render :layout => 'application' }
      format.xml  { render :xml => @deck }
    end
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def create
    @deck = Deck.new(params[:deck])

    respond_to do |format|
      if @deck.save
        flash[:notice] = 'Deck was successfully created.'
        format.html { redirect_to(@deck) }
        format.xml  { render :xml => @deck, :status => :created, :location => @deck }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @deck.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @deck = Deck.find(params[:id])

    respond_to do |format|
      if @deck.update_attributes(params[:deck])
        flash[:notice] = 'Deck was successfully updated.'
        format.html { redirect_to(@deck) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @deck.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to(decks_url) }
      format.xml  { head :ok }
    end
  end
end
