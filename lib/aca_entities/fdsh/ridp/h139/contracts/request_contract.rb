# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for Request
        class RequestContract < Dry::Validation::Contract
          params do
            optional(:PrimaryRequest).maybe(AcaEntities::Fdsh::Ridp::H139::PrimaryRequestContract.params)
            optional(:SecondaryRequest).maybe(AcaEntities::Fdsh::Ridp::H139::SecondaryRequestContract.params)
          end
        end
      end
    end
  end
end