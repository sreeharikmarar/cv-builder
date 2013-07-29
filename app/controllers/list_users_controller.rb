class ListUsersController < ActionController::Base
  
  layout "after-login"

  def index
    @users = User.all
  end
  
end
