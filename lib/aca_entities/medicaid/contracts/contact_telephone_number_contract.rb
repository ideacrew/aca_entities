# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ContactTelephoneNumber
      class ContactTelephoneNumberContract < Dry::Validation::Contract

        params do
          optional(:telephone).maybe(:hash)
        end
      end
    end
  end
end
