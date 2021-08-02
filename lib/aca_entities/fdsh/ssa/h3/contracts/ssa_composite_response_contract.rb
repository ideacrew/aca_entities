# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class SSACompositeResponseContract < Dry::Validation::Contract

          params do
            required(:SSACompositeIndividualResponses).array(AcaEntities::Fdsh::Ssa::H3::SSACompositeIndividualResponseContract.params)
          end
        end
      end
    end
  end
end