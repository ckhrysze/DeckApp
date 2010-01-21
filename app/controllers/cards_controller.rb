class CardsController < ApplicationController
  # GET /cards
  # GET /cards.xml
  def index
    # @cards = Card.all
    #
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @cards }
    #end
    db_config = YAML::load(File.read(RAILS_ROOT + "/config/database.yml"))

    Rails.logger.warn("Setting up mongo connection with config at #{RAILS_ROOT} /config/database.yml")
    mongo = db_config[Rails.env]

    Rails.logger.warn(mongo.inspect)
    Rails.logger.warn("Attempting to log into #{mongo['host']} port #{mongo['port']}")
    
    MongoMapper.connection = Mongo::Connection.new(mongo['host'],
                                                   mongo['port'],
                                                   { :logger => Rails.logger })
    MongoMapper.database = mongo['database']

    if mongo['username'].present?
      Rails.logger.warn("Attempting to pull credentials from env")
      Rails.logger.warn("Env says user is #{ENV['MONGOHQ_USER']}")
      success = MongoMapper.database.authenticate(ENV['MONGOHQ_USER'], ENV['MONGOHQ_PASS'])

      Rails.logger.warn("auth call was successful? #{success}")
    end
  end

  # GET /cards/1
  # GET /cards/1.xml
  def show
    @card = Card.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.xml
  def new
    @card = Card.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @card }
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
  end

  # POST /cards
  # POST /cards.xml
  def create
    @card = Card.new(params[:card])

    respond_to do |format|
      if @card.save
        flash[:notice] = 'Card was successfully created.'
        format.html { redirect_to(@card) }
        format.xml  { render :xml => @card, :status => :created, :location => @card }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cards/1
  # PUT /cards/1.xml
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        flash[:notice] = 'Card was successfully updated.'
        format.html { redirect_to(@card) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.xml
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to(cards_url) }
      format.xml  { head :ok }
    end
  end
end
