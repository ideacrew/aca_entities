# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for CurrentIncomeResponse
        class CurrentIncomeResponseContract < Dry::Validation::Contract
          params do
            required(:request_number).filled(:string)
          end
        end
      end
    end
  end
end