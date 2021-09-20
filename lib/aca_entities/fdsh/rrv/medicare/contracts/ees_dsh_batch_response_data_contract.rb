# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Contract for RRV Medicare
        class EesDshBatchResponseDataContract < Dry::Validation::Contract
          params do
            required(:IndividualResponses).array(AcaEntities::Fdsh::Rrv::Medicare::IndividualResponseContract.params)
          end
        end
      end
    end
  end
end