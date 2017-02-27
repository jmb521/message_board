class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :user_id
      t.integer :profile_id
      t.timestamps
    end
  end
end
