class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.string :phone
      t.text  :photos , array: true, default: []
      t.text  :categories , array: true, default: []
      t.timestamps
    end
  end
end
