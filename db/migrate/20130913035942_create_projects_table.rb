class CreateProjectsTable < ActiveRecord::Migration
   def up
    create_table(:projects) do |t|
      t.integer    :user_id
      t.string     :project_name
      t.text     :project_description
      t.string     :public_url
      t.text     :contribution
      t.string     :technologies
      t.timestamps
    end
  end

  def down
    drop_table :projects
  end
end
