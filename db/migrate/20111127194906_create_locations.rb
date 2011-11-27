class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :vicinity
      t.float :lat
      t.float :lon
      t.string :address
      t.string :places_id
      t.string :reference
      t.integer :event_id
      t.string :city
      t.string :state
      t.string :country_code
      t.string :url
      t.string :icon
      t.string :phone
      t.string :i18n_phone
      t.integer :user_id

      t.timestamps
    end
  end
end
