class Users::DashboardController < ApplicationController
  before_filter :require_user

  layout "after-login"
  
  def index
    @user = current_user
    @linkedin_details = LinkedinDetails.find_by_user_id(current_user.id)
    @company = Keyword::Company.find_by_user_id(current_user.id)
    @industry = Keyword::Industry.find_by_user_id(current_user.id)
    @city = Keyword::City.find_by_user_id(current_user.id)
    @country = Keyword::Country.find_by_user_id(current_user.id)
  end
end
