# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp ResponseMetadataType
          class ResponseMetadataTypeContract < Dry::Validation::Contract
            params do
              required(:responseCode).filled(:string)
              required(:responseDescriptionText).filled(:string)
              optional(:tdsResponseDescriptionText).maybe(:string)
            end
          end
        end
      end
    end
  end
end