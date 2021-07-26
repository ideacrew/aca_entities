# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp I327DocumentId
        class I327DocumentIdContract < Dry::Validation::Contract
          params do
            required(:AlienNumber).filled(:string)
            optional(:DocExpirationDate).maybe(:date)
          end
        end
      end
    end
  end
end