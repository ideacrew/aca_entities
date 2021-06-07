# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for ResponseMetadataType
        class ResponseMetadataTypeContract < Dry::Validation::Contract
          params do
            required(:response_code).filled(:string)
            required(:response_description_text).filled(:string)
            optional(:tds_response_description_text).maybe(:string)
          end
        end
      end
    end
  end
end