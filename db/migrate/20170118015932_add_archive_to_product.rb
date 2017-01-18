class AddArchiveToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :archived, :boolean, default: false
  end
end
