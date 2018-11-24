class CreateBoard < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :start_x, null: false
      t.integer :start_y, null: false
      t.integer :end_x, null: false
      t.integer :end_y, null: false
      t.text :vertical_walls, null: false
      t.text :horizontal_walls, null: false
    end
  end
end
