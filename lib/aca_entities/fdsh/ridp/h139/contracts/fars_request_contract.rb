# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for FarsRequest
        class FarsRequestContract < Dry::Validation::Contract

          params do
            required(:dSH_reference_number).filled(:string)
            required(:subscriber_number).filled(:integer)
          end
        end
      end
    end
  end
end