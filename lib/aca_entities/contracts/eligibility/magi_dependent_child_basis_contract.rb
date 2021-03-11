# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Eligibility
      # contract for MagiDependentChildBasis
      class MagiDependentChildBasisContract < Dry::Validation::Contract

        params do
          required(:covered_code).filled(:string)
          optional(:covered_indicator).maybe(:bool)
          optional(:determination_date).maybe(:date_time)
          optional(:ineligibility_reason).maybe(:string)
        end
      end
    end
  end
end
