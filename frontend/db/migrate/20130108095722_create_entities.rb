class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :uri

      t.timestamps
    end
  end
end
