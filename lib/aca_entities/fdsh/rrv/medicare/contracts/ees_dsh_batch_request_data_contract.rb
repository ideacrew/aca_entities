# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Contract for RRV Medicare
        class EesDshBatchRequestDataContract < Dry::Validation::Contract
          params do
            required(:IndividualRequests).array(AcaEntities::Fdsh::Rrv::Medicare::IndividualRequestContract.params)
          end
        end
      end
    end
  end
end