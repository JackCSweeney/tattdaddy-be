class RemoveColumnProviderFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :provider, :string
  end
end
