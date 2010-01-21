db_config = YAML::load(File.read(RAILS_ROOT + "/config/database.yml"))

if db_config[Rails.env] && db_config[Rails.env]['adapter'] == 'mongodb'
  Rails.logger.info("Setting up mongo connection")
  mongo = db_config[Rails.env]

  Rails.logger.info("Attempting to log into #{mongo['host']} port #{mongo['port']}")

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
