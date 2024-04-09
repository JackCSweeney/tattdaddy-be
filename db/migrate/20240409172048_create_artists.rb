class CreateArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :location

      t.timestamps
    end
  end
end
