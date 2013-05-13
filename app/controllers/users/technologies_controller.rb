class Users::TechnologiesController < ApplicationController
  before_filter :require_user

  layout "after-login"

   
  def edit
    @technologies = TechnicalDetails.find_by_user_id(current_user.id) || TechnicalDetails.new

    respond_to do |format|
      format.js {}
    end
  end

  def create
    @technologies =  TechnicalDetails.find_by_user_id(current_user.id) || TechnicalDetails.new

    @technologies.user_id = current_user.id

    if params[:technologies][:details].blank?
      @technologies.errors.add(:details, "can't be blank")
    else
      @technologies.details = params[:technologies][:details]
    end

    if @technologies.errors.blank?
      @technologies.save
      @technical_details = current_user.technical_details
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
