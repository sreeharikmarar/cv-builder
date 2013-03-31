class CreateGithubDetails < ActiveRecord::Migration
  def up
    create_table(:github_details) do |t|
      t.integer    :user_id
      t.string     :project_name
      t.string     :project_description
      t.string     :public_url
      t.string     :contribution , :limit => 1000
      t.string     :technologies
      t.timestamps
    end
  end

  def down
    drop_table :github_details
  end
end
