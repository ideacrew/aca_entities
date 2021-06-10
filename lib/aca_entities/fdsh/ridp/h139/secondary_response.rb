# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for SecondaryResponse
        class SecondaryResponse < Dry::Struct

          attribute :ResponseCode,                     Types::String.meta(omittable: false) # TODO: types codes
          attribute :ResponseDescriptionText,          Types::String.meta(omittable: false)
          attribute :FinalDecisionCode,                Types::String.meta(omittable: false)
          attribute :DSHReferenceNumber,               Types::String.meta(omittable: false)
          attribute :TDSResponseDescriptionText,       Types::String.optional.meta(omittable: true)
          attribute :SessionIdentification,            Types::String.optional.meta(omittable: true)

        end
      end
    end
  end
end