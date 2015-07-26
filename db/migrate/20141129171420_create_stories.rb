class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.belongs_to :user
      t.belongs_to :category
      t.string :content
      t.integer :longitude
      t.integer :latitude

      t.timestamps
    end
  end
end
