# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for PrimaryResponse
        class PrimaryResponse < Dry::Struct
          attribute :ResponseCode,                      Types::String.meta(omittable: false)
          attribute :ResponseDescriptionText,           Types::String.meta(omittable: false)
          attribute :TDSResponseDescriptionText,        Types::String.meta(omittable: true)
          attribute :SessionIdentification,             Types::String.optional.meta(omittable: true)
          attribute :DSHReferenceNumber,                Types::String.optional.meta(omittable: true)
          attribute :FinalDecisionCode,                 Types::String.optional.meta(omittable: true) # TODO: enum
          attribute :VerificationQuestionText,          Types::Array.of(Types::String).meta(omittable: false)
          attribute :VerificationAnswerChoiceText,       Types::Array.of(Types::String).meta(omittable: false)
        end
      end
    end
  end
end
