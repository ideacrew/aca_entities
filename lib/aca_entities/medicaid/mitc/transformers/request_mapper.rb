# frozen_string_literal: true

require 'dry/transformer'
# require 'dry/transformer/all'

module AcaEntities
  module Medicaid
    module Mitc
      module Transformers
        class RequestMapper < Dry::Transformer::Pipe
          import Dry::Transformer::ArrayTransformations
          import Dry::Transformer::HashTransformations

          define! do
            map_array do
              symbolize_keys
              rename_keys user_name: :'User Name'
              nest :address, [:city, :street, :zipcode]
            end
          end
        end
      end
    end
  end
end
