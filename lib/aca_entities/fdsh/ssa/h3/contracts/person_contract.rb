# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class PersonContract < Dry::Validation::Contract

          params do
            required(:PersonSSNIdentification).filled(:string)
            required(:PersonName).filled(AcaEntities::Fdsh::Contracts::Person::PersonNameContract.params)
            required(:PersonBirthDate).filled(AcaEntities::Fdsh::Contracts::Person::PersonBirthDateContract.params)
          end
        end
      end
    end
  end
end