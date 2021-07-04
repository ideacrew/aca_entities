# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for SecondaryResponse
        class SecondaryResponse < Dry::Struct

          attribute :Response do
            attribute :ResponseMetadata do
              attribute :ResponseCode,                     Types::String.meta(omittable: false)
              attribute :ResponseDescriptionText,          Types::String.meta(omittable: false)
              attribute :TDSResponseDescriptionText,       Types::String.optional.meta(omittable: true)
            end

            attribute :VerificationResponse do
              attribute :FinalDecisionCode,                Types::String.meta(omittable: false)
              attribute :DSHReferenceNumber,               Types::String.meta(omittable: false)
              attribute :SessionIdentification,            Types::String.optional.meta(omittable: true)
            end
          end
        end
      end
    end
  end
end