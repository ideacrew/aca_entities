# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class ESIMECResponseContract < Dry::Validation::Contract
            params do
              required(:ApplicantResponseSet).filled(AcaEntities::Fdsh::Esi::H14::Contracts::ApplicantResponseSetContract.params)
            end
          end
        end
      end
    end
  end
end