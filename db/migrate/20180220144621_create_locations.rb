class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :place_id
      t.float :lat
      t.float :lng
      t.string :vicinity
      t.string :photo
      t.timestamps
    end
  end
end
