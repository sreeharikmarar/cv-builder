class Users::EducationController < ApplicationController
  before_filter :require_user

  layout "after-login"
  
  def new
    @education = EducationDetails.new

    respond_to do |format|
      format.js { render :edit }
    end
  end

  def edit
    @education = EducationDetails.find_by_id_and_user_id(params[:id],current_user.id)

    respond_to do |format|
      format.js {}
    end
  end

  def create
    @education =  EducationDetails.new

   @education.user_id = current_user.id

    if params[:position][:degree].blank?
      @education.errors.add(:degree, "can't be blank")
    else
      @education.degree = params[:position][:degree]
    end

    if params[:position][:field_of_study].blank?
      @education.errors.add(:field_of_study, "can't be blank")
    else
      @education.field_of_study = params[:position][:field_of_study]
    end

    if params[:position][:school_name].blank?
      @education.errors.add(:school_name, "can't be blank")
    else
      @education.school_name = params[:position][:school_name]
    end

    if params[:position][:start_date].blank?
      @education.errors.add(:school_name, "can't be blank")
    else
      @education.start_date = params[:position][:start_date]
    end

    if params[:position][:end_date ].blank?
      @education.errors.add(:end_date , "can't be blank")
    else
      @education.end_date  = params[:position][:end_date ]
    end

    if @education.errors.blank?
      @education.save

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
    @education = EducationDetails.find_by_id_and_user_id(params[:id],current_user.id)
    
    @education.user_id = current_user.id
    
    if params[:position][:degree].blank?
      @education.errors.add(:degree, "can't be blank")
    else
      @education.degree = params[:position][:degree]
    end
    
    if params[:position][:field_of_study].blank?
      @education.errors.add(:field_of_study, "can't be blank")
    else
      @education.field_of_study = params[:position][:field_of_study]
    end
    
    if params[:position][:school_name].blank?
      @education.errors.add(:school_name, "can't be blank")
    else
      @education.school_name = params[:position][:school_name]
    end

    if params[:position][:start_date].blank?
      @education.errors.add(:school_name, "can't be blank")
    else
      @education.start_date = params[:position][:start_date]
    end
    
    if params[:position][:end_date ].blank?
      @education.errors.add(:end_date , "can't be blank")
    else
      @education.end_date  = params[:position][:end_date ]
    end
    

    if @education.errors.blank?
      @education.save

      respond_to do |format|
        format.js { render :create}
      end
    else
      respond_to do |format|
        format.js { render :edit}
      end
    end
  end
  
  def delete
    @education = EducationDetails.find_by_id_and_user_id(params[:id],current_user.id)
    @education.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path}
    end
  end
end
