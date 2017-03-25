class Addscoretobookmarks < ActiveRecord::Migration[5.0]
  def change
    add_column :bookmarks, :score, :integer
  end
end
