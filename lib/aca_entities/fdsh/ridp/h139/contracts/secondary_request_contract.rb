# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for SecondaryRequest
        class SecondaryRequestContract < Dry::Validation::Contract
          params do
            required(:session_identification).filled(:string)
            required(:verification_answer).filled(:integer)
            required(:verification_question_number).filled(:integer)
          end
        end
      end
    end
  end
end