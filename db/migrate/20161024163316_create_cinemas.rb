class CreateCinemas < ActiveRecord::Migration[5.0]
  def change
    create_table :cinemas do |t|
      t.string :name
      t.integer :cw_id

      t.timestamps
    end
  end
end
