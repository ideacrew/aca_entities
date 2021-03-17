# frozen_string_literal: true

module Qbo::Accounts

  # Schema and validation rules for the {CallCenter::Operations::Contacts::ListFlow} operation
  class AccountContract < ApplicationContract

    # @!method call(opts)
    # @param [Hash] opts the parameters to validate using this contract
    # @option opts [String] 'Name' (required)
    # @option opts [Array<CallCenter::Types::ContactFlow>] :contact_flow_types
    # @return [Dry::Monads::Result::Success] if params pass validation
    # @return [Dry::Monads::Result::Failure] if params fail validation
    json do
      # required(:sample).value(format?: /^a/)

      required(:"Name").filled(Qbo::Types::StrippedString, max_size?: 100)

      # required for update
      optional(:"Id").value(Qbo::Types::StrippedString)
      optional(:"SyncToken").value(Qbo::Types::StrippedString)

      optional(:"AcctNum").value(Qbo::Types::StrippedString, max_size?: 7)
      optional(:"AccountType").value(Qbo::Types::StrippedString)
      optional(:"AccountSubType").value(Qbo::Types::StrippedString)

      optional(:"CurrencyRef").hash do 
        required(:"value").filled(Qbo::Types::StrippedString)
        optional(:"name").value(Qbo::Types::StrippedString)
      end

      optional(:"ParentRef").hash do 
        required(:"value").filled(Qbo::Types::StrippedString)
        optional(:"name").value(Qbo::Types::StrippedString)
      end

      optional(:"Description").value(Qbo::Types::StrippedString, max_size?: 100)
      optional(:"Active").value(:bool)
      optional(:"MetaData").value(:hash)

      optional(:"SubAccount").value(:bool)

      optional(:"FullyQualifiedName").value(Qbo::Types::StrippedString)
      optional(:domain).value(Qbo::Types::StrippedString)
      optional(:"Classification").value(Qbo::Types::StrippedString)
      optional(:"CurrentBalanceWithSubAccounts").value(Types::Coercible::Float)
      optional(:sparse).value(:bool)
      optional(:"CurrentBalance").value(Types::Coercible::Float)
    end
  end

end
