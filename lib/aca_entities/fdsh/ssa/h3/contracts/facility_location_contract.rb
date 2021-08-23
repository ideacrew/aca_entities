# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Contract for Ssa Verification contract
        class FacilityLocationContract < Dry::Validation::Contract

          params do
            required(:LocationStreet).filled(:string)
            required(:LocationCityName).filled(:string)
            required(:LocationStateUSPostalServiceCode).filled(:string)
            required(:LocationPostalCode).filled(:string)
            optional(:LocationPostalExtensionCode).maybe(:string)
          end
        end
      end
    end
  end
end