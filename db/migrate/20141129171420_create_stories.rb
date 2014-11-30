class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :content
      t.integer :longitude
      t.integer :lattitude

      t.timestamps
    end
  end
end
