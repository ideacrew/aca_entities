# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonPreferredLanguage.
      class PersonPreferredLanguageContract < Dry::Validation::Contract

        params do
          optional(:language_name).maybe(:string)
          optional(:speaks_language_indicator).maybe(:string)
          optional(:writes_language_indicator).maybe(:string)
        end
      end
    end
  end
end
