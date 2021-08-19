# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Contract for FDSH IndividualResponseSetContract
        class IndividualResponseSetContract < Dry::Validation::Contract
          params do
            required(:IndividualResponses).array(AcaEntities::Fdsh::NonEsi::H31::IndividualResponseContract.params)
          end
        end
      end
    end
  end
end