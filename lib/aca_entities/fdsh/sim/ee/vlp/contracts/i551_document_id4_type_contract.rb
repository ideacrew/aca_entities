# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I551DocumentID4Type
          class I551DocumentID4TypeContract < Dry::Validation::Contract
            params do
              required(:alienNumber).filled(:string)
              required(:receiptNumber).filled(:string)
              optional(:docExpirationDate).maybe(:string)
            end
          end
        end
      end
    end
  end
end