# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      # contract for InitialServiceRequest
      class InitialServiceRequestContract < Dry::Validation::Contract

        params do
          required(:person_given_name).filled(:string)
          required(:person_sur_name).filled(:string)
          optional(:person_middle_name).maybe(:string)
          optional(:person_name_suffix_text).maybe(:string)
          optional(:person_birth_date).maybe(:date)
          optional(:person_ssn_identification).maybe(:string)

          required(:street_name).filled(:string)
          required(:location_city_name).filled(:string)
          required(:location_state_us_postal_service_code).filled(:string)
          required(:location_postal_code).filled(:string)
          optional(:location_postal_extension_code).maybe(:string)

          optional(:full_telephone_number).maybe(:string)
          optional(:level_of_proofing_code).maybe(:string)

          optional(:PersonLanguagePreference).maybe(:string)
          optional(:SubscriberNumber).maybe(:string)
        end
      end
    end
  end
end