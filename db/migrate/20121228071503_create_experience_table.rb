class CreateExperienceTable < ActiveRecord::Migration
  def up
    create_table(:positions) do |t|
      t.integer    :user_id
      t.string     :title
      t.string     :company_name
      t.string     :industry_name
      t.boolean    :is_current , :default => false
      t.string     :start_date
      t.string     :end_date
      t.string     :summary , :limit => 1000
    end
  end

  def down
    drop_table :positions 
  end
end
