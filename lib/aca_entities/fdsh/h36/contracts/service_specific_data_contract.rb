# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 ServiceSpecificDataContract
        class ServiceSpecificDataContract < Dry::Validation::Contract
          params do
            required(:ReportPeriod).hash do
              required(:YearMonth).maybe(:string)
            end
          end
        end
      end
    end
  end
end