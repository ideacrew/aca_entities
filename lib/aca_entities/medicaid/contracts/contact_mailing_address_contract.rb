# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Activity date information contract
      class ContactMailingAddressContract < Dry::Validation::Contract
        params do

          optional(:address).maybe(:hash)
        end
      end
    end
  end
end