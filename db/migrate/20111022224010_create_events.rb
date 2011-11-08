class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :location
      t.date :start
      t.date :finish
      t.text :description
      t.boolean :disabled, :default => false
      t.integer :user_id

      t.timestamps
    end
  end
end
