class CreateArtistIdentities < ActiveRecord::Migration[7.1]
  def change
    create_table :artist_identities do |t|
      t.references :artist, null: false, foreign_key: true
      t.references :identity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
