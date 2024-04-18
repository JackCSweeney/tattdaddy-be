class AddSchedulingLinkToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :scheduling_link, :string
  end
end
