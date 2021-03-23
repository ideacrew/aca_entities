# frozen_string_literal: true

module AcaEntities
  module Google
    module Maps
      # contract for google maps latlng
      class LatLngContract < Dry::Validation::Contract
        json do
          required(:lat).filled(Google::Maps::Types::LatitudeKind)
          required(:lng).filled(Google::Maps::Types::LongitudeKind)
        end
      end
    end
  end
end
