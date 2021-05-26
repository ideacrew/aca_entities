# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp SponsorshipDataType
          class SponsorshipDataTypeContract < Dry::Validation::Contract
            params do
              required(:firstName).filled(:string)
              required(:lastName).filled(:string)
              optional(:middleName).maybe(:string)
              optional(:addr1).maybe(:string)
              optional(:addr2).maybe(:string)
              optional(:city).maybe(:string)
              optional(:stateCode).maybe(:string)
              optional(:zipCode).maybe(:string)
            end
          end
        end
      end
    end
  end
end