class Users::BasicInfoController < ApplicationController
  before_filter :require_user

  layout "after-login"
  
  def edit
    @basic_info = BasicInfo.find_by_user_id(current_user.id) || BasicInfo.new

    respond_to do |format|
      format.js {}
    end
  end

  def create
    @basic_info =  BasicInfo.new

    @basic_info.user_id = current_user.id
    @basic_info.full_name = params[:basic_info][:full_name]
    @basic_info.email = params[:basic_info][:email]
    @basic_info.address = params[:basic_info][:address]
    @basic_info.phone = params[:basic_info][:phone]
    @basic_info.website = params[:basic_info][:website]
    @basic_info.twitter_handle = params[:basic_info][:twitter_handle]
    @basic_info.linkedin_url = params[:basic_info][:linkedin_url]

    @basic_info.save
    
    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
  def update
    @basic_info = BasicInfo.find_by_user_id(current_user.id) 
    
    @basic_info.user_id = current_user.id
    @basic_info.full_name = params[:basic_info][:full_name]
    @basic_info.email = params[:basic_info][:email]
    @basic_info.address = params[:basic_info][:address]
    @basic_info.phone = params[:basic_info][:phone]
    @basic_info.website = params[:basic_info][:website]
    @basic_info.twitter_handle = params[:basic_info][:twitter_handle]
    @basic_info.linkedin_url = params[:basic_info][:linkedin_url]

    @basic_info.save

    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
end
