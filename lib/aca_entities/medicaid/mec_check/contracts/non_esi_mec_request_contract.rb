# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module MecCheck
      module Contracts
        # Contract for NonEsiMecRequest
        class NonEsiMecRequestContract < Dry::Validation::Contract

          params do
            required(:non_esi_mec_individual_information).filled(:hash)
          end
        end
      end
    end
  end
end