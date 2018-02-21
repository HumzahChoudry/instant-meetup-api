class UserMeetups < ActiveRecord::Migration[5.1]
  def change
    create_table :user_meetups, :id => false do |t|
      t.integer :user_id
      t.integer :meetup_id
      t.timestamps
    end
  end
end
