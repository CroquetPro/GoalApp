class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description
      t.integer :user_id, null: false
      t.string :privacy, null: false, default: "Public"
      t.string :status, null: false, default: "Incomplete"
      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end
