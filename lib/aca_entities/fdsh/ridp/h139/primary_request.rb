# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for PrimaryRequest
        class PrimaryRequest < Dry::Struct
          attribute :Person do
            attribute :PersonName do
              attribute :PersonGivenName, Types::String.meta(omittable: false)
              attribute :PersonSurName, Types::String.meta(omittable: false)
              attribute :PersonMiddleName,
                        Types::String.optional.meta(omittable: true)
              attribute :PersonNameSuffixText,
                        Types::String.optional.meta(omittable: true)
            end

            attribute :PersonBirthDate,
                      Types::Date.optional.meta(omittable: true)
            attribute :PersonSSNIdentification,
                      Types::String.optional.meta(omittable: true)
          end

          attribute :CurrentAddress do
            attribute :LocationAddress do
              attribute :StructuredAddress do
                attribute :LocationStreet do
                  attribute :StreetName, Types::String.meta(omittable: false)
                end
                attribute :LocationCityName,
                          Types::String.meta(omittable: false)
                attribute :LocationStateUSPostalServiceCode,
                          AcaEntities::Types::UsStateAbbreviationKind.meta(
                            omittable: false
                          )
                attribute :LocationPostalCode,
                          Types::String.meta(omittable: false)
                attribute :LocationPostalExtensionCode,
                          Types::String.optional.meta(omittable: true)
              end
            end
          end

          attribute :ContactInformation do
            attribute :ContactTelephoneNumber do
              attribute :FullTelephoneNumber,
                        Types::String.optional.meta(omittable: true)
            end
          end

          attribute :LevelOfProofingCode,
                    AcaEntities::Fdsh::Ridp::H139::Types::LevelOfProofingCodeKind
                      .optional.meta(omittable: true)

          attribute :PersonLanguagePreference,
                    AcaEntities::Fdsh::Ridp::H139::Types::PersonLanguagePreference
                      .meta(omittable: true)
          attribute :SubscriberNumber,
                    Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end
