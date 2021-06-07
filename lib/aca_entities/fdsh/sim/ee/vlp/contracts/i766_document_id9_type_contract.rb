# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I766DocumentID9Type
          class I766DocumentID9TypeContract < Dry::Validation::Contract
            params do
              required(:receiptNumber).filled(:string)
              optional(:alienNumber).maybe(:string)
              optional(:docExpirationDate).maybe(:string)
            end
          end
        end
      end
    end
  end
end