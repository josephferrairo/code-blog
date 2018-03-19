class CreateProfile < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.text :biography
      t.string :web_browser
      t.string :text_editor
      t.string :terminal
      t.integer :user_id
      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
