# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for MedicaidSpecificInformation.
      class MedicaidSpecificInformationContract < Dry::Validation::Contract

        params do
          optional(:medical_bills_in_last_90_days).maybe(:bool)
        end
      end
    end
  end
end
