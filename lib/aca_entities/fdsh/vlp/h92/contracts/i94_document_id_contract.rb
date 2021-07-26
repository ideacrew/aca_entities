# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp I94DocumentId
        class I94DocumentIdContract < Dry::Validation::Contract
          params do
            required(:I94Number).filled(:string)
            optional(:SEVISID).maybe(:string)
            optional(:DocExpirationDate).maybe(:date)
          end
        end
      end
    end
  end
end