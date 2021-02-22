# frozen_string_literal: true

module AcaEntities
  module Iap
    module Mitc
      module Validators
        class DeprivedChildContract < Dry::Validation::Contract

          params do
            required(:qualify_as_deprived_child).filled(Types::YesNoKind)
          end
        end
      end
    end
  end
end
