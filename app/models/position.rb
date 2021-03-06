# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class Position < ActiveRecord::Base

  ## Set the table name
  set_table_name "positions"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id, :title , :company_name , :industry_name , :is_current , :start_date , :end_date , :summary

  validates :title , :presence => true
  validates :company_name , :presence => true
  validates :industry_name , :presence => true
  validates :start_date , :presence => true
  validates :end_date , :presence => true
end
