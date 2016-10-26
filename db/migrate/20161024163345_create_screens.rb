class CreateScreens < ActiveRecord::Migration[5.0]
  def change
    create_table :screens do |t|
      t.string :name
      t.integer :number
      t.references :cinema, foreign_key: true

      t.timestamps
    end
  end
end
