# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class RequestPersonContract < Dry::Validation::Contract
          params do
            required(:PersonBirthDate).filled(:date)
            required(:PersonName).filled(AcaEntities::Fdsh::Contracts::Person::PersonNameContract.params)
            optional(:PersonSexCode).maybe(:string)
            required(:PersonSSNIdentification).filled(AcaEntities::Fdsh::Contracts::Person::PersonSSNIdentificationContract.params)
          end
        end
      end
    end
  end
end