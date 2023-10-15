class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|

      t.references :user, null: false
      t.text :introduction
      t.integer :gender
      t.date :birthday
      t.timestamps
    end
  end
end
