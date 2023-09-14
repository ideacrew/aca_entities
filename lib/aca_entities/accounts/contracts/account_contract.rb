# frozen_string_literal: true

module AcaEntities
  module Accounts
    module Contracts
      # Schema and validation rules for {AcaEntities::Accounts::Account}
      class AccountContract < Contract
        params do
          optional(:id).maybe(:string)
          required(:provider).filled(:string)
          required(:uid).filled(:string)
          required(:name).filled(:string)
          optional(:email).maybe(AcaEntities::Types::EmailAddressKind)
          optional(:encrypted_password).maybe(:string)
          optional(:created_at).maybe(:time)
          optional(:updated_at).maybe(:time)
        end
      end
    end
  end
end
