# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      # contract for FarsResponse
      class FarsResponseContract < Dry::Validation::Contract

        params do
          required(:response_code).filled(:string)
          required(:response_description_text).filled(:string)
          optional(:final_decision_code).maybe(:string)

          required(:person_given_name).filled(:string)
          required(:person_sur_name).filled(:string)
          optional(:person_middle_name).maybe(:string)
          required(:street_name).filled(:string)
          required(:location_city_name).filled(:string)
          required(:location_state_us_postal_service_code).filled(:string)
          required(:location_postal_code).filled(:string)
          optional(:location_postal_extension_code).maybe(:string)

          optional(:tds_response_description_text).maybe(:string)
        end
      end
    end
  end
end