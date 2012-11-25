class CreateKeywordsTable < ActiveRecord::Migration
  def up
    create_table(:keywords) do |t|

      t.integer :user_id
      t.string :type
      t.string :name
      

    end
  end

  def down
    drop_table :keywords
  end
end
