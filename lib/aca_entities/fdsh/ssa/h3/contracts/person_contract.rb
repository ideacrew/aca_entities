# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class PersonContract < Dry::Validation::Contract

          params do
            required(:PersonSSNIdentification).filled(:string)
            required(:PersonName).filled(AcaEntities::Fdsh::Person::PersonName.params)
            required(:PersonBirthDate).filled(AcaEntities::Fdsh::Person::PersonBirthDate.params)
          end
        end
      end
    end
  end
end