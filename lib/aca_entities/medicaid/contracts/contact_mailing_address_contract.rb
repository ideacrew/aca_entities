# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for ContactMailingAddress.
      class ContactMailingAddressContract < Dry::Validation::Contract

        params do
          optional(:address).maybe(:hash)
        end
      end
    end
  end
end
