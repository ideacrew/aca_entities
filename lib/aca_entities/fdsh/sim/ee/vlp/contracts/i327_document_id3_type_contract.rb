# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I327DocumentID3Type
          class I327DocumentID3TypeContract < Dry::Validation::Contract
            params do
              required(:alienNumber).filled(:string)
              optional(:docExpirationDate).filled(:string)
            end
          end
        end
      end
    end
  end
end