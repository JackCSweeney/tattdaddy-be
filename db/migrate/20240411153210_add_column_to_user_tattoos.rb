class AddColumnToUserTattoos < ActiveRecord::Migration[7.1]
  def change
    add_column :user_tattoos, :status, :integer
  end
end
