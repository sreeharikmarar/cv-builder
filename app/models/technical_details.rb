# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class TechnicalDetails < ActiveRecord::Base

  ## Set the table name
  set_table_name "technical_details"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id , :details

  def self.parse_technical_details(user, profile)
     user.technical_details.delete if user.technical_details

      all_skills = []
      profile.skills.all.each do |item|
      all_skills << item.skill.name
      end
      @tech_details = TechnicalDetails.new
      @tech_details.user_id = user.id
      @tech_details.details = "Skills : " + all_skills[1..-1].join(" , ")
      @tech_details.save
  end
end
