class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :department_id
      t.string :role

      t.timestamps null: false
    end
    add_index :users, :department_id
    add_index :users, :role
  end

  def down
    drop_table :users
  end
end
