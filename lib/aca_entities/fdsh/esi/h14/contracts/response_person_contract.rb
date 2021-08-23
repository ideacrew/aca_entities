# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class ResponsePersonContract < Dry::Validation::Contract
          params do
            required(:PersonSSNIdentification).filled(AcaEntities::Fdsh::Contracts::Person::PersonSSNIdentificationContract.params)
          end
        end
      end
    end
  end
end