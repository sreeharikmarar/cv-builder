class ShareCvTable < ActiveRecord::Migration
  def up
    create_table(:share_cvs) do |t|
      t.integer :user_id
      t.string  :url
      t.string  :theme
      t.boolean :publish , :default => true
    end
  end

  def down
    drop_table :share_cvs
  end
end
