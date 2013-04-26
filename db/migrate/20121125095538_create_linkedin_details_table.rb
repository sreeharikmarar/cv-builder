class CreateLinkedinDetailsTable < ActiveRecord::Migration
  def up
    create_table(:linkedin_details) do |t|
      
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :headline
      t.string :location
      t.string :year
      t.string :month
      t.string :day
      t.string :phone_number
      t.string :main_address
      t.string :twitter_account
      t.string :public_profile_url
      t.string :personal_website

    end
  end

  def down
    drop_table :linkedin_details
  end
end
