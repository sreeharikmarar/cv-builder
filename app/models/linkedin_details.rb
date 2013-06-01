# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class LinkedinDetails < ActiveRecord::Base

  ## Set the table name
  set_table_name "linkedin_details"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id, :first_name , :last_name , :email , :headline , :public_profile_url, :year ,:month ,:day, :twitter_account, :main_address , :phone_number , :location , :personal_website
  validates :year, :presence=>true
  validates :month, :presence=>true
  validates :day, :presence=>true

  def self.parse_linkedin1(user, profile_1)

    ## Storing Personal Detail
    
    @linkedin_detail = user.linkedin_details || LinkedinDetails.new
    
    @linkedin_detail.user_id = user.id
    @linkedin_detail.email = user.email
    @linkedin_detail.first_name = profile_1.first_name unless profile_1.first_name.blank?
    @linkedin_detail.last_name = profile_1.last_name unless profile_1.last_name.blank?
    @linkedin_detail.headline = profile_1.headline unless profile_1.headline.blank?
    @linkedin_detail.public_profile_url = profile_1.public_profile_url unless profile_1.public_profile_url.blank?
    @linkedin_detail.year = profile_1.date_of_birth.year  unless profile_1.date_of_birth.year.blank?
    @linkedin_detail.month = profile_1.date_of_birth.month unless profile_1.date_of_birth.month.blank?
    @linkedin_detail.day = profile_1.date_of_birth.day unless profile_1.date_of_birth.day.blank?
    @linkedin_detail.twitter_account = profile_1.primary_twitter_account.provider_account_name unless profile_1.primary_twitter_account.provider_account_name.blank?
    @linkedin_detail.main_address = profile_1.main_address unless profile_1.main_address.blank?
    @linkedin_detail.phone_number = profile_1.phone_numbers.all.first.phone_number if  profile_1.phone_numbers.any? && profile_1.phone_numbers.all.first.phone_number

    
    @linkedin_detail.location = profile_1.location.name unless profile_1.location.blank?

    @linkedin_detail.save(:validate => false)
      

  end
  def self.parse_linkedin_2(user, profile_2)
    user.positions.destroy_all if user.positions
    
    if profile_2.positions && profile_2.positions.all && profile_2.positions.all.any?
      profile_2.positions.all.each do |pos|
        @position_details = Position.new
        @position_details.user_id = user.id
        
        @position_details.title = pos.title if pos.title
        @position_details.summary = pos.summary if pos.summary
        @position_details.is_current = pos.is_current
        @position_details.company_name = pos.company.name
        @position_details.industry_name = pos.company.industry

        if pos.is_current
          
          begin
            
            if pos.start_date && (pos.start_date.month && pos.start_date.year)
              start_date = "1,#{pos.start_date.month},#{pos.start_date.year}"
              end_date = "present"
            end
          rescue
            
            start_date = nil
            end_date = nil
          end
          @position_details.start_date = start_date
          @position_details.end_date = end_date
        else
          
          begin
           
            if pos.start_date && pos.end_date
              if (pos.start_date.month && pos.end_date.month)  && (pos.start_date.year && pos.end_date.year)
                start_date = "1,#{pos.start_date.month},#{pos.start_date.year}"
                end_date = "1,#{pos.end_date.month},#{pos.end_date.year}"
              end
            end
          rescue
           
            start_date = nil
            end_date = nil
          end
          @position_details.start_date = start_date
          @position_details.end_date = end_date
         
        end
        @position_details.save
      end
    end
 
  
  end


    def self.parse_linkedin_3(user, profile_3)

      EducationDetails.parse_education_details(user, profile_3)
      TechnicalDetails.parse_technical_details(user, profile_3)
    end
  
end
