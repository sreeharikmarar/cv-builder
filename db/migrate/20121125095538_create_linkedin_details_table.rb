class CreateLinkedinDetailsTable < ActiveRecord::Migration
  def up
    create_table(:linkedin_details) do |t|
      
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :headline
      t.integer :company_id
      t.integer :country_id
      t.integer :city_id
      t.integer :industry_id

    end
  end

  def down
    drop_table :linkedin_details
  end
end
