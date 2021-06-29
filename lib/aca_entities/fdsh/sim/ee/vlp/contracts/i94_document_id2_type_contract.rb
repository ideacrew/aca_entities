# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp I94DocumentID2Type
          class I94DocumentID2TypeContract < Dry::Validation::Contract
            params do
              required(:i94Number).filled(:string)
              optional(:sevisid).maybe(:string)
              optional(:docExpirationDate).maybe(:date)
            end
          end
        end
      end
    end
  end
end