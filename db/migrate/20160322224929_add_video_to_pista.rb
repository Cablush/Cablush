class AddVideoToPista < ActiveRecord::Migration
  def change
    add_column :pistas, :video, :string, {limit: 150}
  end
end
