# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Contract for validating Keycloak {AcaEntities::Accounts::Account}
      class AccountContract < Dry::Validation::Contract
        params do
          optional(:id).maybe(:string)
          required(:username).filled(:string)
          optional(:enabled).maybe(:bool)
          optional(:totp).maybe(:bool)
          optional(:email).maybe(AcaEntities::Types::EmailAddressKind)
          optional(:email_verified).maybe(:bool)
          optional(:first_name).maybe(:string)
          optional(:last_name).maybe(:string)
          optional(:password).maybe(:string)
          optional(:attributes).maybe(:hash)
          optional(:groups).array(:string)
          optional(:access).maybe(:hash)
          optional(:not_before).maybe(:integer)
          optional(:created_at).maybe(:date_time)
        end
      end
    end
  end
end
