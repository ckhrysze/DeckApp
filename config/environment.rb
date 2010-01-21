# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

require 'plugins/app_config/lib/configuration'
Rails::Initializer.run do |config|
  config.gem 'mongo_mapper', :version => '>= 0.6.10'
  config.frameworks -= [:active_record]
end

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
    Rails.logger.info("Attempting to pull credentials from env")
    Rails.logger.info("Env says user is #{ENV['MONGOHQ_USER']}")
    success = MongoMapper.database.authenticate(ENV['MONGOHQ_USER'], ENV['MONGOHQ_PASS'])

    Rails.logger.info("auth call was successful? #{success}")

    begin
      raise "Mongo auth failed" unless success
    rescue => e
      Rails.logger.info("auth failed, tell hoptoad about it")
      var_hash = {:params => mongo}.merge(:user => ENV['MONGOHQ_USER'])
      result = HoptoadNotifier.notify(:error_class   => "MongoHQ connection failure",
                                      :error_message => "MongoHQ connection failure: #{e.message}",
                                      :request       => var_hash
                                      )
    end
  end
end

