class TattoosSerializer
  include JSONAPI::Serializer
  attributes :image_url, :price, :time_estimate, :artist_id

  belongs_to :artist do
    data do
      {
        scheduling_link: @object.artist.scheduling_link
      }
    end
  end
end
