# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Contract for validating Keycloak {AcaEntities::Accounts::Account}
      class AccountContract < Dry::Validation::Contract
        params do
          optional(:username).maybe(:string)
          optional(:email).maybe(:string)
          optional(:first_name).maybe(:string)
          optional(:last_name).maybe(:string)
          optional(:password).maybe(:string)
          optional(:attributes).maybe(:hash)
          optional(:groups).array(:string)
          optional(:timestamps).maybe(
            AcaEntities::Contracts::TimeStampContract.params
          )
        end
      end
    end
  end
end
