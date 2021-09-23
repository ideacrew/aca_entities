# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      module Contracts
        # Contract for VerifyNonEsiMecRequest
        class VerifyNonEsiMecRequestContract < Dry::Validation::Contract

          params do
            required(:non_esi_mec_request).filled(:hash)
          end
        end
      end
    end
  end
end