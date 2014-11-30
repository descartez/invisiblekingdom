class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.belongs_to :user
      t.string :content
      t.integer :longitude
      t.integer :lattitude

      t.timestamps
    end
  end
end
