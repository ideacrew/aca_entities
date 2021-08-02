# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp I571DocumentId
        class I571DocumentIdContract < Dry::Validation::Contract
          params do
            optional(:AlienNumber).filled(:string)
            optional(:DocExpirationDate).filled(:date)
          end
        end
      end
    end
  end
end