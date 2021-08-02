# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp I551DocumentId
        class I551DocumentIdContract < Dry::Validation::Contract
          params do
            required(:AlienNumber).filled(:string)
            required(:ReceiptNumber).filled(:string)
            optional(:DocExpirationDate).maybe(:string)
          end
        end
      end
    end
  end
end