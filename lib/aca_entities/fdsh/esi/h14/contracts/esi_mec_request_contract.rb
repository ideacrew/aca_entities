# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class ESIMECRequestContract < Dry::Validation::Contract
          params do
            required(:ApplicantRequests).array(AcaEntities::Fdsh::Esi::H14::ApplicantRequestContract.params)
          end
        end
      end
    end
  end
end