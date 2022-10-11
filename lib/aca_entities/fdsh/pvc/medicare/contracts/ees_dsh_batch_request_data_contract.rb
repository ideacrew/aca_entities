# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Pvc
      module Medicare
        # Contract for PVC Medicare
        class EesDshBatchRequestDataContract < Dry::Validation::Contract
          params do
            required(:IndividualRequests).array(AcaEntities::Fdsh::Pvc::Medicare::IndividualRequestContract.params)
          end
        end
      end
    end
  end
end