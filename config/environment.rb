# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

require 'plugins/app_config/lib/configuration'
Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.app_config.my_key = 'my value'

  #"4ec43e7f1fcbbbcd998b73210c3fbff40fd6c421"
end
