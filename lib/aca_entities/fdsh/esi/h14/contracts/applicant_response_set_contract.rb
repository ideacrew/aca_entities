# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class ApplicantResponseSetContract < Dry::Validation::Contract
          params do
            required(:ApplicantResponses).array(AcaEntities::Fdsh::Esi::H14::ApplicantResponseContract.params)
          end
        end
      end
    end
  end
end