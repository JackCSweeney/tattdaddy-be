class AddTokenToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :token, :string
  end
end
