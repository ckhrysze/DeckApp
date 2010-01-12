class RpxController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:index] # RPX does not pass Rails form tokens...

  def index
    u = URI.parse('https://rpxnow.com/api/v2/auth_info')
    req = Net::HTTP::Post.new(u.path)
    req.set_form_data({'token' => params[:token],
                       'apiKey' => '4ec43e7f1fcbbbcd998b73210c3fbff40fd6c421',
                       'format' => 'json'})

    http = Net::HTTP.new(u.host, u.port)
    http.use_ssl = true if u.scheme == 'https'
    res = http.request(req)

    json_resp = res.body
    json = JSON.parse(json_resp)

    if json['stat'] == 'ok'
      unique_identifier = json['profile']['identifier']
      nickname = json['profile']['preferredUsername']
      nickname = json['profile']['displayName'] if nickname.nil?
      email = json['profile']['email']
      provider_name = json['profile']['providerName']
      photo_url = json['profile']['photo']

      # implement your own do_success method which signs the user in
      # to your website
      #User.find(:all, :conditions => {'identifiers.ident' => 'asdfasdf'})
      ident = Identifier.find_or_create(unique_identifier, provider_name)
      user = User.find_or_create(ident, email, nickname, photo_url)
      session[:user] = user.id
      session[:ident] = unique_identifier

    else
      flash[:notice] = 'Log in failed'
      redirect_to '/'
    end

    def logout
    
    end

  end
end
