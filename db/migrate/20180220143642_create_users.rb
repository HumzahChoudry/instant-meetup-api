class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :profile_pic
      t.string :status
      t.float :current_latitude
      t.float :current_longitude
      t.string :password_digest
      t.timestamps
    end
  end
end
