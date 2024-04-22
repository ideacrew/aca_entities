# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for RRV ServiceSpecificDataContract
        class ServiceSpecificDataContract < Dry::Validation::Contract
          params do
            optional(:ReportPeriod).hash do
              optional(:Year).maybe(:integer)
            end

            optional(:OriginalBatchID).maybe(:string)
          end
        end
      end
    end
  end
end
