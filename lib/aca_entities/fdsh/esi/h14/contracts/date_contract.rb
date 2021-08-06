# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Esi
      module H14
        module Contracts
          # Contract for FDSH ESI Verification contract
          class DateContract < Dry::Validation::Contract
            params do
              required(:Date).filled(:Date)
            end
          end
        end
      end
    end
  end
end