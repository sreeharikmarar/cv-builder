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
    @technologies =  TechnicalDetails.new

    @technologies.user_id = current_user.id
    @technologies.details = params[:technologies][:details]
   

    @technologies.save
    
    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
  def update
     @technologies = TechnicalDetails.find_by_user_id(current_user.id)
    
     @technologies.user_id = current_user.id
     @technologies.details = params[:technologies][:details]


    @technologies.save

    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
end
