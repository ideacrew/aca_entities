# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      module Contracts
        # Contract for RequestedInsurancePeriod
        class RequestedInsurancePeriodContract < Dry::Validation::Contract

          params do
            required(:start_date).filled(:date)
            required(:end_date).filled(:date)
          end
        end
      end
    end
  end
end