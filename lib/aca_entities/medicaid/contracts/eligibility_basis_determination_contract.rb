# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for EligibilityBasisDetermination
      class EligibilityBasisDeterminationContract < Dry::Validation::Contract

        params do
          optional(:activity_identification).maybe(:hash)
          optional(:activity_date).maybe(:hash)
        end
      end
    end
  end
end
