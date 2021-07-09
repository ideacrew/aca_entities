# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for PrimaryRequest
        class PrimaryRequestContract < Dry::Validation::Contract
          params do
            required(:Person).schema do
              required(:PersonName).schema do
                required(:PersonGivenName).filled(:string)
                required(:PersonSurName).filled(:string)
                optional(:PersonMiddleName).maybe(:string)
                optional(:PersonNameSuffixText).maybe(:string)
              end

              optional(:PersonBirthDate).maybe(:date)
              optional(:PersonSSNIdentification).maybe(:string)
            end

            required(:CurrentAddress).schema do
              required(:LocationAddress).schema do
                required(:StructuredAddress).schema do
                  required(:LocationStreet).schema do
                    required(:StreetName).filled(:string)
                  end
                  required(:LocationCityName).filled(:string)
                  required(:LocationStateUSPostalServiceCode).filled(
                    AcaEntities::Types::UsStateAbbreviationKind
                  )
                  required(:LocationPostalCode).filled(:string)
                  optional(:LocationPostalExtensionCode).maybe(:string)
                end
              end
            end

            optional(:ContactInformation).schema do
              optional(:ContactTelephoneNumber).schema do
                optional(:FullTelephoneNumber).maybe(:string)
              end
            end

            optional(:LevelOfProofingCode).maybe(
              AcaEntities::Fdsh::Ridp::H139::Types::LevelOfProofingCodeKind
            )

            optional(:PersonLanguagePreference).maybe(
              AcaEntities::Fdsh::Ridp::H139::Types::PersonLanguagePreference
            )
            optional(:SubscriberNumber).maybe(:string)
          end
        end
      end
    end
  end
end
