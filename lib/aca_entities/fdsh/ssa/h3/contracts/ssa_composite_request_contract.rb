# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class SsaCompositeRequestContract < Dry::Validation::Contract

          params do
            required(:SSACompositeIndividualRequests).array(AcaEntities::Fdsh::Ssa::H3::SsaCompositeIndividualRequestContract.params)
          end
        end
      end
    end
  end
end