# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for SecondaryRequest
        class SecondaryRequest < Dry::Struct
          attribute :SessionIdentification,          Types::String.meta(omittable: false)
          attribute :VerificationAnswer,             Types::Integer.meta(omittable: false)
          attribute :VerificationQuestionNumber,    Types::Integer.meta(omittable: false)

        end
      end
    end
  end
end