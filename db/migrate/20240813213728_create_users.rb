class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.float :balance
      t.string :first_name
      t.string :last_name
      t.string :nid

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :nid, unique: true
  end
end
