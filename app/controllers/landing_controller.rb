class LandingController < ApplicationController
  def index
    @user = session[:user].nil? ? nil : User.find(session[:user])
  end
end
