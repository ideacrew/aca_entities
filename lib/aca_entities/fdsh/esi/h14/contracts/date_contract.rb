# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        # Contract for FDSH ESI Verification contract
        class DateContract < Dry::Validation::Contract
          params do
            required(:Date).filled(:date)
          end
        end
      end
    end
  end
end