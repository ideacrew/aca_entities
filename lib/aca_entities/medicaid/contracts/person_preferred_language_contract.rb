# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for PersonPreferredLanguage.
      class PersonPreferredLanguageContract < Dry::Validation::Contract

        params do
          optional(:language_name).maybe(:string)
        end
      end
    end
  end
end
