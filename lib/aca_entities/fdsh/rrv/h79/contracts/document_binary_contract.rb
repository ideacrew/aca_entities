# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        # Contract for RRV DocumentBinaryContract
        class DocumentBinaryContract < Dry::Validation::Contract
          params do
            required(:ChecksumAugmentation).schema do
              required(:SHA256HashValueText).filled(:string)
            end
            required(:BinarySizeValue).filled(:decimal)
          end
        end
      end
    end
  end
end