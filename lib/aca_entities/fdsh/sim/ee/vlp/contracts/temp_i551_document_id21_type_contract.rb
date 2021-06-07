# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp TempI551DocumentID21Type
          class TempI551DocumentID21TypeContract < Dry::Validation::Contract
            params do
              required(:alienNumber).filled(:string)
              required(:passportCountry).filled(:string)
              optional(:docExpirationDate).maybe(:date)
            end
          end
        end
      end
    end
  end
end