class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :service_uri
      t.string :auth_token
      t.string :alias
      t.references :user
      t.timestamps
    end
  end
end
