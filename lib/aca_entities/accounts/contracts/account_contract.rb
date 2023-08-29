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
          optional(:email).filled(:string)

          optional(:timestamp).hash(AcaEntities::Contracts::TimeStampContract.params)
        end
      end
    end
  end
end
