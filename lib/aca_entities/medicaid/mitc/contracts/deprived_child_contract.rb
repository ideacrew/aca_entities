# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Mitc
      module Contracts
        # Contract for DeprivedChild.
        class DeprivedChildContract < Dry::Validation::Contract

          params do
            required(:qualify_as_deprived_child).filled(Types::YesNoKind)
          end
        end
      end
    end
  end
end
