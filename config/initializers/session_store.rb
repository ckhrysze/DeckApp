# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_deckapp_session',
  :secret      => 'e1d345497a4cb95364ea8546c911b9e3c96b83dc7204c1e224bfcb77128a5e2c7431fa8811a11c8811813d0849e95c3fb6536a94bd6c06ad2036845373eace29'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
