# Author : Krishnaprasad Varma (kpvarma@presciencesoft.com)
# Date : 2 Jun, 2011
# All code (c)2011 Prescience Soft Pvt. Ltd. All rights reserved

class Projects < ActiveRecord::Base

  ## Set the table name
  set_table_name "projects"

  belongs_to :user, :class_name=>"User", :foreign_key=>"user_id"

  
  ## Specifies a white list of attributes that can be set via mass-assignment.
  attr_accessible :user_id, :project_name , :project_description ,:public_url , :technologies , :created_at , :updated_at , :contribution

  validates :project_name , :presence => true
  validates :project_description , :presence => true
  validates :public_url ,:format => { :with => /((http|https):\/\/.+\..+)|((www\.).+\..+)\z/ }, :unless=> Proc.new { |p| p.public_url.blank? || p.public_url == "http://" }

end
