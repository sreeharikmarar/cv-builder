class Users::DashboardController < ApplicationController
  before_filter :require_user

  layout "after-login"
  
  def index
    @user = current_user
  end
end
