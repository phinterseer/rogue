class AddFieldsToCinema < ActiveRecord::Migration[5.0]
  def change
    add_column :cinemas, :site_id, :integer
    add_column :cinemas, :url, :string
    rename_column :cinemas, :cw_id, :website_id
  end
end
