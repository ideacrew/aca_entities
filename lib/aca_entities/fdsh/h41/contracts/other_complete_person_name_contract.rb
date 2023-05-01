# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      module Contracts
        # Contract for H41 OtherCompletePersonNameContract
        class OtherCompletePersonNameContract < Dry::Validation::Contract
          params do
            required(:PersonFirstNm).filled(:string)
            optional(:PersonMiddleNm).maybe(:string)
            required(:PersonLastNm).filled(:string)
            optional(:SuffixNm).maybe(:string)
          end
        end
      end
    end
  end
end