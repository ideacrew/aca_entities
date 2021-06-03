# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for CurrentIncomeInfoType
        class CurrentIncomeInfoTypeContract < Dry::Validation::Contract
          params do
            required(:response_metadata).filled(Fdsh::Ridp::H139::VerificationMetadataTypeContract.params)
            required(:employee_information).filled(Fdsh::Ridp::H139::PersonTypeContract.params)
            required(:current_income_information).array(Fdsh::Ridp::H139::CurrentHouseholdIncomeTypeContract.params)
          end
        end
      end
    end
  end
end