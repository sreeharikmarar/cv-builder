# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class Position < ActiveRecord::Base

  ## Set the table name
  set_table_name "positions"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id, :title , :company_id , :industry_id , :is_current , :start_date , :end_date , :summary

end
