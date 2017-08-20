class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :dim_locations do |t|
      t.text :name

      t.timestamps
    end
  end
end
