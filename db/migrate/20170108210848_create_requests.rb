class CreateRequests < ActiveRecord::Migration
  def up
    create_table :requests do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :unique_id
      t.integer :department_id
      t.integer :requested_by
      t.integer :updated_by

      t.timestamps null: false
    end
    add_index :requests, :department_id
    add_index :requests, :requested_by
    add_index :requests, :updated_by
  end

  def down
    drop_table :requests
  end
end
