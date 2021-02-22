# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      module Validators
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
