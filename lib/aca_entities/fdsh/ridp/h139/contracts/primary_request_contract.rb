# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for PrimaryRequest
        class PrimaryRequestContract < Dry::Validation::Contract

          params do
            required(:PersonGivenName).filled(:string)
            required(:PersonSurName).filled(:string)
            optional(:PersonMiddleName).maybe(:string)
            optional(:PersonNameSuffixText).maybe(:string)
            optional(:PersonBirthDate).maybe(:date)
            optional(:PersonSSNIdentification).maybe(:string)

            required(:StreetName).filled(:string)
            required(:LocationCityName).filled(:string)
            required(:LocationStateUSPostalServiceCode).filled(AcaEntities::Fdsh::Ridp::H139::Types::UsStateAbbreviationKind)
            required(:LocationPostalCode).filled(:string)
            optional(:LocationPostalExtensionCode).maybe(:string)

            optional(:FullTelephoneNumber).maybe(:string)
            optional(:LevelOfProofingCode).maybe(AcaEntities::Fdsh::Ridp::H139::Types::LevelOfProofingCodeKind)

            optional(:PersonLanguagePreference).maybe(AcaEntities::Fdsh::Ridp::H139::Types::PersonLanguagePreference)
            optional(:SubscriberNumber).maybe(:string)
          end
        end
      end
    end
  end
end