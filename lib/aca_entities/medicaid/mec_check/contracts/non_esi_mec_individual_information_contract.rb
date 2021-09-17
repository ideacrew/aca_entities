# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      module Contracts
        # Contract for NonEsiMecIndividualInformation
        class NonEsiMecIndividualInformationContract < Dry::Validation::Contract

          params do
            optional(:person_ssn).maybe(:string)
            required(:person_name).filled(:hash)
            required(:person_date_of_birth).filled(:date)
            optional(:person_sex_code).maybe(:string)
            required(:requested_insurance_period).filled(:hash)
            required(:organization_code).filled(:string)
          end
        end
      end
    end
  end
end