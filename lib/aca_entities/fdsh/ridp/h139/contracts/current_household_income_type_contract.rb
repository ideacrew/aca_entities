# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for CurrentHouseholdIncomeType
        class CurrentHouseholdIncomeTypeContract < Dry::Validation::Contract

          params do
            required(:PayPeriod).filled(Fdsh::Ridp::H139::PayPeriodInformationTypeContract.params)
            required(:verification_metadata).filled(Fdsh::Ridp::H139::VerificationMetadataTypeContract.params)
            required(:employee_information).filled(Fdsh::Ridp::H139::PersonTypeContract.params)
            required(:employer_information).filled(Fdsh::Ridp::H139::EmployerInfoTypeContract.params)
            required(:employment_info_type).filled(Fdsh::Ridp::H139::EmploymentInfoTypeContract.params)
            optional(:base_compensation_information).maybe(Fdsh::Ridp::H139::BaseCompensationInfoTypeContract.params)
            optional(:annual_compensation).maybe(Fdsh::Ridp::H139::AnnualCompensationTypeContract.params)
            optional(:tier).maybe(:integer)
            optional(:as_of_date).maybe(:date)
          end
        end
      end
    end
  end
end