# Mocks the OpenID auth to always return :successful
OpenIdAuthentication.module_eval do
  protected
  def authenticate_with_open_id(identity_url, fields)
    yield OpenIdAuthentication::Result[:successful], identity_url, nil
  end
end