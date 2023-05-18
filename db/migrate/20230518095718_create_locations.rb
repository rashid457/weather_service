class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|   
      t.string :name
      t.string :region
      t.string :country
      t.string :lat
      t.string :lon
      t.string :condition
      t.string :icon
      t.decimal :temparature
      t.decimal :wind
      t.integer :humidity
      t.integer :cloud
      t.integer :last_updated_at  

      t.timestamps
    end
  end
end



