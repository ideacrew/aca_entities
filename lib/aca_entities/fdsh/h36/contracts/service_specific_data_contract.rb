# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 ServiceSpecificDataContract
        class ServiceSpecificDataContract < Dry::Validation::Contract
          params do
            optional(:ReportPeriod).hash do
              optional(:Year).maybe(:integer)
            end
          end
        end
      end
    end
  end
end