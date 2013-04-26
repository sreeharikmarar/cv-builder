# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class EducationDetails < ActiveRecord::Base

  ## Set the table name
  set_table_name "education_details"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id , :degree , :field_of_study , :school_name , :start_date , :end_date

  def self.parse_education_details(user, profile)
     user.education_details.destroy_all if user.education_details.any?

      profile.educations.all.each do |item|
      @education_detail = EducationDetails.new
      @education_detail.user_id = user.id
      @education_detail.degree = item.degree
      @education_detail.field_of_study = item.field_of_study
      @education_detail.school_name = item.school_name
      @education_detail.start_date = item.start_date.year
      @education_detail.end_date = item.end_date.year
      @education_detail.save
      end
  end
end
