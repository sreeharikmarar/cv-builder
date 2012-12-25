class CreateTableBasicInfo < ActiveRecord::Migration
  def up
    create_table(:basic_info) do |t|

      t.integer :user_id
      t.string  :full_name
      t.string  :email
      t.string  :address
      t.integer :phone
      t.string  :website
      t.string  :twitter_handle
      t.string  :linkedin_url

    end
  end

  def down
    drop_table :basic_info
  end
end
