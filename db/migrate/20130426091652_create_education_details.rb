class CreateEducationDetails < ActiveRecord::Migration
  def up
    create_table(:education_details) do |t|
      t.integer    :user_id
      t.string     :degree
      t.string     :field_of_study
      t.string     :school_name
      t.string     :start_date
      t.string     :end_date
    end
  end

  def down
    drop_table :education_details
  end
end
