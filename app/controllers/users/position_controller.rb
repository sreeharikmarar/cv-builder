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

    if params[:position][:company_name].blank?
      @position.errors.add(:company_name, "can't be blank")
    else
      @position.company_name = params[:position][:company_name]
    end
    if params[:position][:industry_name].blank?
      @position.errors.add(:industry_name, "can't be blank")
    else
      @position.industry_name = params[:position][:industry_name]
    end
    
    @position.is_current = params[:position][:is_current]

    if params[:position][:start_date].blank?
      @position.errors.add(:start_date, "can't be blank")
    else
      @position.start_date = params[:position][:start_date]
    end
    
    if @position.is_current
      @position.end_date = "present"
    else
      if params[:position][:end_date].blank?
        @position.errors.add(:end_date, "can't be blank")
      else
        @position.end_date = params[:position][:end_date]
      end
    end
    
    unless params[:position][:end_date ].blank? && params[:position][:start_date].blank?
      if params[:position][:start_date ].to_i >= params[:position][:end_date].to_i
        @position.errors.add(:start_date , "Start Date should be less than End date")
      end
    end

    @position.summary = params[:position][:summary]

    if @position.errors.blank?
      @position.save
      @experience_details = current_user.positions if current_user.positions.any?
      respond_to do |format|
        format.js { render :create}
      end
    else
      respond_to do |format|
        format.js { render :edit }
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
      @experience_details = current_user.positions if current_user.positions.any?
      respond_to do |format|
        format.js { render :create}
      end
    else
      respond_to do |format|
        format.js { render :edit }
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
