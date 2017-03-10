class CreateBookmarksTags < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks_tags, id: false do |t|
      t.belongs_to :bookmark, index: true
      t.belongs_to :tag, index: trua
    end
  end
end
