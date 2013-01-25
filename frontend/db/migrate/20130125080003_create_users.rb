class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :unique => true
      t.string :password
      t.integer :active_host_key
      t.timestamps
    end
  end
end

