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
    unless params[:basic_info][:email].blank?
      email_pattern = /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,3}/i
      unless @basic_info.email.match(email_pattern)
        @basic_info.errors.add(:email,"Should be valid")
      else
        @basic_info.email = params[:basic_info][:email]
      end
    end
    @basic_info.year = params[:basic_info][:year]
    @basic_info.month = params[:basic_info][:month]
    @basic_info.day = params[:basic_info][:day]
    @basic_info.main_address = params[:basic_info][:main_address]
    unless params[:basic_info][:phone_number].blank?
      if params[:basic_info][:phone_number].length < 3
        @basic_info.errors.add(:phone_number, "Number is too short, minimum 3 characters.")
      elsif params[:basic_info][:phone_number].length > 25
        @basic_info.errors.add(:phone_number, "Number is too long, maximum 28 characters.")
      elsif  /[!@%&*()_={}<>:;"'?\,.]/.match(params[:basic_info][:phone_number])
        @basic_info.errors.add(:phone_number, "Number is invalid, Enter Valid Numbers")
      else
        @basic_info.phone_number = params[:basic_info][:phone_number]
      end
    end
    @basic_info.personal_website = params[:basic_info][:personal_website]
    @basic_info.twitter_account = params[:basic_info][:twitter_account]
    @basic_info.public_profile_url = params[:basic_info][:public_profile_url]

   if @basic_info.errors.blank?
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

    unless params[:basic_info][:email].blank?
      email_pattern = /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,3}/i
      unless @basic_info.email.match(email_pattern)
        @basic_info.errors.add(:email,"Should be valid")
      else
        @basic_info.email = params[:basic_info][:email]
      end
    end

    @basic_info.year = params[:basic_info][:year]
    @basic_info.month = params[:basic_info][:month]
    @basic_info.day = params[:basic_info][:day]
    @basic_info.main_address = params[:basic_info][:main_address]

    unless params[:basic_info][:phone_number].blank?
      if params[:basic_info][:phone_number].length < 3
        @basic_info.errors.add(:phone_number, "Number is too short, minimum 3 characters.")
      elsif params[:basic_info][:phone_number].length > 25
        @basic_info.errors.add(:phone_number, "Number is too long, maximum 28 characters.")
      elsif  /[!@%&*()_={}<>:;"'?\,.]/.match(params[:basic_info][:phone_number])
        @basic_info.errors.add(:phone_number, "Number is invalid, Enter Valid Numbers")
      else
        @basic_info.phone_number = params[:basic_info][:phone_number]
      end
    end

    @basic_info.personal_website = params[:basic_info][:personal_website]
    @basic_info.twitter_account = params[:basic_info][:twitter_account]
    @basic_info.public_profile_url = params[:basic_info][:public_profile_url]

    if @basic_info.errors.blank?
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
