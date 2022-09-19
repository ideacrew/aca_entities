# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Contract for PVC Medicare
        class EesDshBatchResponseDataContract < Dry::Validation::Contract
          params do
            required(:IndividualResponses).array(AcaEntities::Fdsh::Pvc::Medicare::IndividualResponseContract.params)
          end
        end
      end
    end
  end
end