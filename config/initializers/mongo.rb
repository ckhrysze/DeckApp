db_config = YAML::load(File.read(RAILS_ROOT + "/config/mongo_database.yml"))

if db_config[Rails.env] && db_config[Rails.env]['adapter'] == 'mongodb'
  mongo = db_config[Rails.env]
  MongoMapper.connection = Mongo::Connection.new(mongo['host'], mongo['port'],
                                                 { :logger => Rails.logger })
  MongoMapper.database = mongo['database']

  if mongo['username'].present?
    MongoMapper.database.authenticate(ENV['MONGOHQ_USER'], ENV['MONGOHQ_PASS'])
  end
end
