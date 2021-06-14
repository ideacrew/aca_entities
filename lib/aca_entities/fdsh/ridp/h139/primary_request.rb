# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for PrimaryRequest
        class PrimaryRequest < Dry::Struct
          attribute :PersonGivenName,                       Types::String.meta(omittable: false)
          attribute :PersonSurName,                         Types::String.meta(omittable: false)
          attribute :PersonMiddleName,                      Types::String.optional.meta(omittable: true)
          attribute :PersonNameSuffixText,                  Types::String.optional.meta(omittable: true)

          attribute :PersonBirthDate,                       Types::Date.optional.meta(omittable: true)
          attribute :PersonSSNIdentification,               Types::String.optional.meta(omittable: true)

          attribute :StreetName,                            Types::String.meta(omittable: false)
          attribute :LocationCityName,                      Types::String.meta(omittable: false)
          attribute :LocationStateUSPostalServiceCode,      AcaEntities::Fdsh::Ridp::H139::Types::UsStateAbbreviationKind.meta(omittable: false)
          attribute :LocationPostalCode,                    Types::String.meta(omittable: false)
          attribute :LocationPostalExtensionCode,           Types::String.optional.meta(omittable: true)

          attribute :FullTelephoneNumber,                   Types::String.optional.meta(omittable: true)
          attribute :LevelOfProofingCode,
                    AcaEntities::Fdsh::Ridp::H139::Types::LevelOfProofingCodeKind.optional.meta(omittable: true)

          attribute :PersonLanguagePreference,              AcaEntities::Fdsh::Ridp::H139::Types::PersonLanguagePreference.meta(omittable: true)
          attribute :SubscriberNumber,                      Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end
