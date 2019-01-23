class AddVisitsToUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :visits, :integer, default: 0
  end
end
