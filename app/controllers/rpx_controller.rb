class RpxController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => [:index] # RPX does not pass Rails form tokens...

  def index
    raise "hackers?" unless data = RPXNow.user_data(params[:token])
    data = []
    RPXNow.user_data(params[:token], rpx_token) { |raw| data = raw['profile'] }
    @user = User.find_or_initialize_with_rpx(data)
    self.current_user = @user
    redirect_to root_path
  end
end
