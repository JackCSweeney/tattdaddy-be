class CreateUserTattoos < ActiveRecord::Migration[7.1]
  def change
    create_table :user_tattoos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tattoo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
