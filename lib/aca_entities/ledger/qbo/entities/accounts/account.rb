# frozen_string_literal: true

module Qbo::Accounts
  class Account < Dry::Struct

    attribute :"Name",                           Types::Strict::String.meta(omittable: false)
    attribute :"Id",                             Types::Strict::String.meta(omittable: true)
    attribute :"SyncToken",                      Types::Strict::String.meta(omittable: true)

    attribute :"AcctNum",                        Types::Strict::String.meta(omittable: true)
    attribute :"AccountType",                    Types::Strict::String.meta(omittable: true)
    attribute :"AccountSubType",                 Types::Strict::String.meta(omittable: true)

    attribute :"CurrencyRef", Dry::Struct.meta(omittable: true) do
      attribute :"value",                        Types::Strict::String.meta(omittable: true)
      attribute :"name",                         Types::Strict::String.meta(omittable: true)
    end

    attribute :"ParentRef", Dry::Struct.meta(omittable: true) do
      attribute :"value",                        Types::Strict::String.meta(omittable: true)
      attribute :"name",                         Types::Strict::String.meta(omittable: true)
    end

    attribute :"Description",                     Types::Strict::String.meta(omittable: true)
    attribute :"Active",                          Types::Bool.meta(omittable: true)
    attribute :"MetaData",                        Types::Hash.meta(omittable: true)

    attribute :"SubAccount",                      Types::Bool.meta(omittable: true)

    attribute :"FullyQualifiedName",              Types::Strict::String.meta(omittable: true)
    attribute :"domain",                          Types::Strict::String.meta(omittable: true)
    attribute :"Classification",                  Types::Strict::String.meta(omittable: true)
    attribute :"CurrentBalanceWithSubAccounts",   Types::Float.meta(omittable: true)
    attribute :"sparse",                          Types::Bool.meta(omittable: true)
    attribute :"CurrentBalance",                  Types::Float.meta(omittable: true)

  end
end