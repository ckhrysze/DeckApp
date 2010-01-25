class DecksController < ApplicationController

  before_filter :require_login

  def mana_curve_chart
    @deck = Deck.find(params[:id])
    render :json => {:src => @deck.mana_curve_chart, :alt => "mana curve chart"}.to_json
  end

  def index
    @decks = @user.decks.all

    respond_to do |format|
      format.html { render :layout => 'application' }
      format.xml  { render :xml => @decks }
    end
  end

  def show
    @deck = @user.decks.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml
    end
  end

  def new
    @deck = @user.decks.build
    #render :edit
  end

  def edit
    @deck = @user.decks.find(params[:id])
  end

  def create
    @deck = @user.decks.build(params[:deck])

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

  def rename
    @deck = @user.decks.find(params[:id])
    puts "Old name #{@deck.name}"
    Rails.logger.info("Old name #{@deck.name}")
    new_name = params[:name]
    @deck.name = new_name
    @deck.save
    puts "New name #{@deck.name}"
    Rails.logger.info("New name #{@deck.name}")

    render :json => @deck.to_json
  end

  def update
    @deck = @user.decks.find(params[:id])

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
    @deck = @user.decks.find(params[:id])
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to(decks_url) }
      format.xml  { head :ok }
    end
  end
end
