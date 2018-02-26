class CreateMeetups < ActiveRecord::Migration[5.1]
  def change
    create_table :meetups do |t|
      t.integer :location_id
      t.boolean :public
      t.references :host
      t.timestamps
    end
  end
end
