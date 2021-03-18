# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for preference
      class PreferenceContract < Dry::Validation::Contract

        params do
          optional(:spoken_language).maybe(:string)
          optional(:written_language).maybe(:string)
          optional(:notification_email_address).maybe(:string)
          required(:contact_preference_Code).filled(:string)
        end
      end
    end
  end
end
