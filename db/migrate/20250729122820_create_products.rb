class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.string :brand
      t.string :image_url

      t.timestamps
    end
  end
end
