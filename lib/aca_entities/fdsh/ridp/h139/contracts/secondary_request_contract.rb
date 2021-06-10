# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for SecondaryRequest
        class SecondaryRequestContract < Dry::Validation::Contract
          params do
            required(:SessionIdentification).filled(:string)
            required(:VerificationAnswer).filled(:integer)
            required(:VerificationQuestionNumber).filled(:integer)
          end
        end
      end
    end
  end
end