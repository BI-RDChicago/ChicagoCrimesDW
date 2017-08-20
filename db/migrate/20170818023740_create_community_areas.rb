class CreateCommunityAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :dim_community_areas do |t|
      t.integer :source_id
      t.text :description

      t.timestamps
    end
  end
end
