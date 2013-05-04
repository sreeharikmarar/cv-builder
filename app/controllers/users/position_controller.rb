class Users::PositionController < ApplicationController
  before_filter :require_user

  layout "after-login"
  
  def new
    @position = Position.new

    respond_to do |format|
      format.js { render :edit }
    end
  end

  def edit
    @position = Position.find_by_id_and_user_id(params[:id],current_user.id)

    respond_to do |format|
      format.js {}
    end
  end

  def create
    @position =  Position.new

    @position.user_id = current_user.id
    @position.title = params[:position][:title]
    @position.company_name = params[:position][:company_name]
    @position.industry_name = params[:position][:industry_name]
    @position.is_current = params[:position][:is_current]
    @position.start_date = params[:position][:start_date]
    @position.end_date = params[:position][:end_date]
    @position.summary = params[:position][:summary]

    @position.save
    
    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
  
  def update
    @position = Position.find_by_id_and_user_id(params[:id],current_user.id)
    
    @position.user_id = current_user.id
    @position.title = params[:position][:title]
    @position.company_name = params[:position][:company_name]
    @position.industry_name = params[:position][:industry_name]
    @position.is_current = params[:position][:is_current]
    @position.start_date = params[:position][:start_date]
    @position.end_date = params[:position][:end_date]
    @position.summary = params[:position][:summary]

    @position.save

    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
  def delete
    @position = Position.find_by_id_and_user_id(params[:id],current_user.id)
    @position.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
end
