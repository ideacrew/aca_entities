module Google::Maps
  class Viewport < Dry::Struct

    attribute :northeast,  Google::Maps::LatLng.meta(omittable: false)
    attribute :southwest,  Google::Maps::LatLng.meta(omittable: false)
    
  end
end
