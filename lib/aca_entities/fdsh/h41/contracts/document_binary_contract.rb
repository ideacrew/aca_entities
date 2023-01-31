# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for RRV DocumentBinaryContract
        class DocumentBinaryContract < Dry::Validation::Contract
          params do
            required(:ChecksumAugmentation).schema do
              required(:SHA256HashValueText).filled(:string)
            end
            required(:BinarySizeValue).filled(:integer)
          end
        end
      end
    end
  end
end