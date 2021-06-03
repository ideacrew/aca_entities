# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I571DocumentID5Type
          class I571DocumentID5TypeContract < Dry::Validation::Contract
            params do
              optional(:alienNumber).filled(:string)
              optional(:docExpirationDate).filled(:date)
            end
          end
        end
      end
    end
  end
end