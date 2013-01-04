class CreateExperienceTable < ActiveRecord::Migration
  def up
    create_table(:positions) do |t|
      t.integer    :user_id
      t.string     :title
      t.integer    :company_id
      t.integer    :industry_id
      t.boolean    :is_current
      t.string     :start_date
      t.string     :end_date
      t.string     :summary , :limit => 1000
    end
  end

  def down
    drop_table :positions 
  end
end
