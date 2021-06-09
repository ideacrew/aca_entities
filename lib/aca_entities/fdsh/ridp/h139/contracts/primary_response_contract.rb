# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for PrimaryResponse
        class PrimaryResponseContract < Dry::Validation::Contract
          params do
            required(:response_code).filled(:string)
            required(:response_description_text).filled(:string)
            optional(:session_identification).maybe(:string)
            optional(:dsh_reference_number).maybe(:string)
            optional(:final_decision_code).maybe(:string)
            required(:verification_question_text).array(:string)
            required(:verification_answer_choice_text).array(:string)
          end
        end
      end
    end
  end
end