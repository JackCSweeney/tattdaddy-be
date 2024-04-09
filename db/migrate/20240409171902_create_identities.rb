class CreateIdentities < ActiveRecord::Migration[7.1]
  def change
    create_table :identities do |t|
      t.string :identity_label

      t.timestamps
    end
  end
end
