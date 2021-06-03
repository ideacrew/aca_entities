# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp MacReadI551DocumentID22Type
          class MacReadI551DocumentID22TypeContract < Dry::Validation::Contract
            params do
              required(:alienNumber).filled(:string)
              required(:passportNumber).filled(:string)
              required(:countryOfIssuance).filled(:string)
              optional(:visaNumber).maybe(:string)
              optional(:docExpirationDate).maybe(:date)
            end
          end
        end
      end
    end
  end
end