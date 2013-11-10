# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class ShareCv < ActiveRecord::Base

  ## Set the table name
  set_table_name "share_cvs"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id, :url ,:publish ,:theme

end
