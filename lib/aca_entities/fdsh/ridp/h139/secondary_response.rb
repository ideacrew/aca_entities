# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for SecondaryResponse
        class SecondaryResponse < Dry::Struct

          attribute :response_code,                      Types::String.meta(omittable: false) # TODO: types codes
          attribute :response_description_text,          Types::String.meta(omittable: false)
          attribute :final_decision_code,                Types::String.meta(omittable: false)
          attribute :dsh_reference_number,               Types::String.meta(omittable: false)
          attribute :tds_response_description_text,      Types::String.optional.meta(omittable: true)
          attribute :session_identification,             Types::String.optional.meta(omittable: true)

        end
      end
    end
  end
end