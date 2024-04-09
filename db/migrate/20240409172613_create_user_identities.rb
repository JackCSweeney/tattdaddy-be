class CreateUserIdentities < ActiveRecord::Migration[7.1]
  def change
    create_table :user_identities do |t|
      t.references :identity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
