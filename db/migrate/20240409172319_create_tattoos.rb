class CreateTattoos < ActiveRecord::Migration[7.1]
  def change
    create_table :tattoos do |t|
      t.string :image_url
      t.integer :price
      t.integer :time_estimate
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
