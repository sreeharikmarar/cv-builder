class Users::BasicInfoController < ApplicationController
  before_filter :require_user

  layout "after-login"
  
  def edit
    @basic_info = LinkedinDetails.find_by_user_id(current_user.id) || LinkedinDetails.new

    respond_to do |format|
      format.js {}
    end
  end

  def create
    @basic_info =  LinkedinDetails.new

    @basic_info.user_id = current_user.id
    @basic_info.first_name = params[:basic_info][:first_name]
    @basic_info.last_name = params[:basic_info][:last_name]
    @basic_info.email = params[:basic_info][:email]
    @basic_info.year = params[:basic_info][:year]
    @basic_info.month = params[:basic_info][:month]
    @basic_info.day = params[:basic_info][:day]
    @basic_info.main_address = params[:basic_info][:main_address]
    @basic_info.phone_number = params[:basic_info][:phone_number]
    @basic_info.personal_website = params[:basic_info][:personal_website]
    @basic_info.twitter_account = params[:basic_info][:twitter_account]
    @basic_info.public_profile_url = params[:basic_info][:public_profile_url]

   if @basic_info.valid?
      @basic_info.save
      @linkedin_details = current_user.linkedin_details
      respond_to do |format|
        format.js { render :create}
      end
    else
      respond_to do |format|
        format.js { render :edit}
      end
    end
  end
  
  def update
    @basic_info = LinkedinDetails.find_by_user_id(current_user.id)
    
    @basic_info.user_id = current_user.id
    @basic_info.first_name = params[:basic_info][:first_name]
    @basic_info.last_name = params[:basic_info][:last_name]
    @basic_info.email = params[:basic_info][:email]
    @basic_info.year = params[:basic_info][:year]
    @basic_info.month = params[:basic_info][:month]
    @basic_info.day = params[:basic_info][:day]
    @basic_info.main_address = params[:basic_info][:main_address]
    @basic_info.phone_number = params[:basic_info][:phone_number]

    @basic_info.personal_website = params[:basic_info][:personal_website]
    @basic_info.twitter_account = params[:basic_info][:twitter_account]
    @basic_info.public_profile_url = params[:basic_info][:public_profile_url]

    if @basic_info.valid?
      @basic_info.save
      @linkedin_details = current_user.linkedin_details
      respond_to do |format|
        format.js { render :create}
      end
    else
      respond_to do |format|
        format.js { render :edit}
      end
    end
  end
end
