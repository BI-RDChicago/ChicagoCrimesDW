class CreateIucrs < ActiveRecord::Migration[5.0]
  def change
    create_table :dim_iucrs do |t|
      t.text :iucr_code
      t.text :primary_description
      t.text :secondary_description

      t.timestamps
    end
  end
end
