# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      module Contracts
        # Contract for H36 OtherCompletePersonNameContract
        class OtherCompletePersonNameContract < Dry::Validation::Contract
          params do
            required(:PersonFirstName).filled(:string)
            optional(:PersonMiddleName).maybe(:string)
            required(:PersonLastName).filled(:string)
            optional(:SuffixName).maybe(:string)
          end
        end
      end
    end
  end
end