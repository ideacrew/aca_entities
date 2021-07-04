# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for IncomeType
        class PersonTypeContract < Dry::Validation::Contract
          params do
            required(:person_name).filled(:string)
            required(:Person_birth_date).filled(:date)
            required(:person_ssn_identification).filled(:string)
          end
        end
      end
    end
  end
end