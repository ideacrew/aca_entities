# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for PrimaryRequest
        class PrimaryRequest < Dry::Struct
          attribute :person_given_name,                       Types::String.meta(omittable: false)
          attribute :person_sur_name,                         Types::String.meta(omittable: false)
          attribute :person_middle_name,                      Types::String.optional.meta(omittable: true)
          attribute :person_name_suffix_text,                 Types::String.optional.meta(omittable: true)
          attribute :person_birth_date,                       Types::Date.optional.meta(omittable: true)
          attribute :person_ssn_identification,               Types::String.optional.meta(omittable: true)

          attribute :street_name,                             Types::String.meta(omittable: false)
          attribute :location_city_name,                      Types::String.meta(omittable: false)
          attribute :location_state_us_postal_service_code,   AcaEntities::Fdsh::Ridp::H139::Types::UsStateAbbreviationKind.meta(omittable: false)
          attribute :location_postal_code,                    Types::String.meta(omittable: false)
          attribute :location_postal_extension_code,          Types::String.optional.meta(omittable: true)

          attribute :full_telephone_number,                   Types::String.optional.meta(omittable: true)
          attribute :level_of_proofing_code,
                    AcaEntities::Fdsh::Ridp::H139::Types::LevelOfProofingCodeKind.optional.meta(omittable: true)

          attribute :person_language_preference,               AcaEntities::Fdsh::Ridp::H139::Types::PersonLanguagePreference.meta(omittable: true)
          attribute :subscriber_number,                        Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end