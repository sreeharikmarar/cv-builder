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
    if params[:position][:title].blank?
      @position.errors.add(:title, "can't be blank")
    else
      @position.title = params[:position][:title]
    end
    @position.company_name = params[:position][:company_name]
    @position.industry_name = params[:position][:industry_name]
    @position.is_current = params[:position][:is_current]
    @position.start_date = params[:position][:start_date]
    if @position.is_current
      @position.end_date = "present"
    else
      @position.end_date = params[:position][:end_date]
    end
    @position.summary = params[:position][:summary]

     if @position.errors.blank?
        @position.save

      respond_to do |format|
        format.html { redirect_to dashboard_path}
      end
    else
      respond_to do |format|
        format.js { render :edit}
      end
    end
    
  end
  
  def update
    @position = Position.find_by_id_and_user_id(params[:id],current_user.id)
    
    @position.user_id = current_user.id
    if params[:position][:title].blank?
      @position.errors.add(:title, "can't be blank")
    else
      @position.title = params[:position][:title]
    end
    
    @position.company_name = params[:position][:company_name]
    @position.industry_name = params[:position][:industry_name]
    @position.is_current = params[:position][:is_current]
    @position.start_date = params[:position][:start_date]
    if @position.is_current
      @position.end_date = "present"
    else
      @position.end_date = params[:position][:end_date]
    end
    @position.summary = params[:position][:summary]

    if @position.errors.blank?
        @position.save

      respond_to do |format|
        format.html { redirect_to dashboard_path}
      end
    else
      respond_to do |format|
        format.js { render :edit}
      end
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
