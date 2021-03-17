# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Mitc
      module Contracts
        # Contract for CategoryDetermination.
        class CategoryDeterminationContract < Dry::Validation::Contract

          params do
            required(:indicator_code).filled(Types::DeterminationIndicatorKind)
            required(:ineligibility_code).filled(:integer)
            optional(:ineligibility_reason).maybe(:string)
          end
        end
      end
    end
  end
end
