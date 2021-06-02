# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      # Entity for FarsResponse
      class FarsResponse < Dry::Struct
        attribute :response_code,                           Types::String.meta(omittable: false)
        attribute :response_description_text,               Types::String.meta(omittable: false)
        attribute :final_decision_code,                     Types::String.optional.meta(omittable: true) # TODO: type enum response codes

        attribute :person_given_name,                       Types::String.meta(omittable: false)
        attribute :person_sur_name,                         Types::String.meta(omittable: false)
        attribute :person_middle_name,                      Types::String.optional.meta(omittable: true)
        attribute :street_name,                             Types::String.meta(omittable: false)
        attribute :location_city_name,                      Types::String.meta(omittable: false)
        attribute :location_state_us_postal_service_code,   Types::String.meta(omittable: false) # TODO: type enum state
        attribute :location_postal_code,                    Types::String.meta(omittable: false)
        attribute :location_postal_extension_code,          Types::String.optional.meta(omittable: true)

        attribute :tds_response_description_text,           Types::String.optional.meta(omittable: true)
      end
    end
  end
end