# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      # Entity for InitialServiceRequest
      class InitialServiceRequest < Dry::Struct
        attribute :person_given_name,                       Types::String.meta(omittable: false)
        attribute :person_sur_name,                         Types::String.meta(omittable: false)
        attribute :person_middle_name,                      Types::String.optional.meta(omittable: true)
        attribute :person_name_suffix_text,                 Types::String.optional.meta(omittable: true)
        attribute :person_birth_date,                       Types::Date.optional.meta(omittable: true)
        attribute :person_ssn_identification,               Types::String.optional.meta(omittable: true)

        attribute :street_name,                             Types::String.meta(omittable: false)
        attribute :location_city_name,                      Types::String.meta(omittable: false)
        attribute :location_state_us_postal_service_code,   Types::String.meta(omittable: false) # TODO: type enum state
        attribute :location_postal_code,                    Types::String.meta(omittable: false)
        attribute :location_postal_extension_code,          Types::String.optional.meta(omittable: true)

        attribute :full_telephone_number,                   Types::String.optional.meta(omittable: true)
        attribute :level_of_proofing_code,                  Types::String.optional.meta(omittable: true) # TODO: type enum state

        attribute :PersonLanguagePreference,                Types::String.optional.meta(omittable: true)
        attribute :SubscriberNumber,                        Types::String.optional.meta(omittable: true)
      end
    end
  end
end