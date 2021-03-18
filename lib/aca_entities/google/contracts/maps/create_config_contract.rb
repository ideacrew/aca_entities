# frozen_string_literal: true

module Google::Maps

  # Schema and validation rules for the {Google::Maps::CreateConfigContract} operation
  class CreateConfigContract < ApplicationContract

    # @!method call(opts)
    # @param [Hash] opts the parameters to validate using this contract
    # @option opts [LatLng] :center required
    # @option opts [Google::Maps::Types::ZoomKind] :zoom required
    # @return [Dry::Monads::Result] result
    json do
      required(:center).hash do
        required(:lat).filled(Google::Maps::Types::LatitudeKind)
        required(:lng).filled(Google::Maps::Types::LongitudeKind)
      end
      required(:zoom).filled(:integer)
    end

    # rule (:center) do
    #   if key? and Google::Maps::LatLng
    #     result = Google::Maps::LatLng.new.call(value)
    #     key.failure(text: "Lat & Long not parsable", error: result.errors.to_h) if result && result.failure
    #   end
    # end
  end
end