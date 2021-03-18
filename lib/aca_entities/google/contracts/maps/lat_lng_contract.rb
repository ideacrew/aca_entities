module Google::Maps
  class LatLngContract < ApplicationContract
    json do
      required(:lat).filled(Google::Maps::Types::LatitudeKind)
      required(:lng).filled(Google::Maps::Types::LongitudeKind)
    end
  end
end
