class CreateTableForTechnicalDetails < ActiveRecord::Migration
  def up
    create_table(:technical_details) do |t|
      t.integer :user_id
      t.string :details , :limit => 100000
    end
  end

  def down
  end
end
