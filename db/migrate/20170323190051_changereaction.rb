class Changereaction < ActiveRecord::Migration[5.0]
  def change
    change_column :reactions, :liked, :integer
  end
end
