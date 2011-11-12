class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :user_id
      t.boolean :activated
      t.string :identifier
      t.string :typel
      
      t.timestamps
    end
  end
end
