# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Schema and validation rules for {AcaEntities::Accounts::Account}
      class AccountContract < Contract
        params do
          optional(:id).filled(:string)
          required(:provider).filled(:string)
          required(:uid).filled(:string)
          required(:name).filled(:string)
          optional(:email).value(AcaEntities::Types::EmailAddressKind)
          optional(:encrypted_password).value(:string)
          optional(:created_at).value(:time)
          optional(:updated_at).value(:time)
        end
      end
    end
  end
end
