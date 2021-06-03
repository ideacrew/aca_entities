# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Contract for CurrentIncomeRequestPayloadType
        class CurrentIncomeRequestPayloadTypeContract < Dry::Validation::Contract
          params do
            required(:person).array(Fdsh::Ridp::H139::PersonTypeContract.params)
          end
        end
      end
    end
  end
end