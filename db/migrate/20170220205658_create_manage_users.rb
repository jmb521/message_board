class CreateManageUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :manage_users do |t|

      t.timestamps
    end
  end
end
