# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # contract for SecondaryResponse
        class SecondaryResponseContract < Dry::Validation::Contract

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
end