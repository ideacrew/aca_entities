# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class RequestPersonContract < Dry::Validation::Contract
            params do
              required(:PersonBirthDate).filled(AcaEntities::Fdsh::Contracts::PersonBirthDateContract.params)
              required(:PersonName).filled(AcaEntities::Fdsh::Contracts::PersonNameContract.params)
              optional(:PersonSexCode).maybe(:string)
              required(:PersonSSNIdentification).filled(AcaEntities::Fdsh::Contracts::PersonSSNIdentificationContract.params)
            end
          end
        end
      end
    end
  end
end