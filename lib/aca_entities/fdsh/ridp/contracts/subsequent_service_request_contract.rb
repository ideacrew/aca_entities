# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      # contract for SubsequentServiceRequest
      class SubsequentServiceRequestContract < Dry::Validation::Contract
        params do
          required(:session_identification).filled(:string)
          required(:verification_answer).filled(:integer)
          required(:verification_question_number).filled(:integer)
        end
      end
    end
  end
end