class Keyword::Base < ActiveRecord::Base

  ## Set the table name
  set_table_name "keywords"

  belongs_to :user

  attr_accessible :name, :type ,:user_id
  
end