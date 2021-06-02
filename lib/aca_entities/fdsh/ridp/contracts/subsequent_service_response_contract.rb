# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      # contract for SubsequentServiceResponse
      class SubsequentServiceResponseContract < Dry::Validation::Contract

        params do
          required(:response_code).filled(:string)
          required(:response_description_text).filled(:string)
          required(:final_decision_code).filled(:string)
          required(:dsh_reference_number).filled(:string)
          optional(:tds_response_description_text).maybe(:string)
          optional(:session_identification).maybe(:string)
        end
      end
    end
  end
end