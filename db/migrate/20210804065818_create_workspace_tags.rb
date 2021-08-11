class CreateWorkspaceTags < ActiveRecord::Migration[6.0]
  def change
    create_table :workspace_tags do |t|
      t.integer :workspace_id
      t.integer :tag_type
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
