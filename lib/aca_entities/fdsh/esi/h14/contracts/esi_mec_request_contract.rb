# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class ESIMECRequestContract < Dry::Validation::Contract
            params do
              required(:ApplicantRequests).array(AcaEntities::Fdsh::Esi::H14::Contracts::ApplicantRequestContract.params)
            end
          end
        end
      end
    end
  end
end