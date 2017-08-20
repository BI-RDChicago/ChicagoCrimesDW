class CreateCrimes < ActiveRecord::Migration[5.0]
  def change
    create_table :fact_crimes do |t|
      t.references :dim_community_areas, foreign_key: true
      t.references :dim_times, foreign_key: true
      t.references :dim_iucrs, foreign_key: true
      t.references :dim_locations, foreign_key: true
      t.integer :quantity
      t.integer :arrest_qnt

      t.timestamps
    end
  end
end
