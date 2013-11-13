class Users::DashboardController < ApplicationController

  before_filter :require_user 

  layout "after-login"
  
  def index
    @user = current_user
    @linkedin_details = current_user.linkedin_details if current_user.linkedin_details
    @experience_details = current_user.positions if current_user.positions.any?
    @github_details = current_user.github_details if current_user.github_details.any?
    @education_details = current_user.education_details if current_user.education_details.any?
    @technical_details = current_user.technical_details
    @projects = current_user.projects if current_user.projects.any?
  end
end
