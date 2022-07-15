# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp I766DocumentId
        class I766DocumentIdContract < Dry::Validation::Contract
          params do
            required(:ReceiptNumber).filled(:string)
            optional(:AlienNumber).maybe(:string)
            optional(:DocExpirationDate).maybe(:date)
          end
        end
      end
    end
  end
end