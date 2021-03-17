module Qbo::Vendors
  class Vendor < Dry::Struct

    attribute :"GivenName",                      Types::Strict::String.meta(omittable: true)
    attribute :"DisplayName",                    Types::Strict::String.meta(omittable: false)
    attribute :"FamilyName",                     Types::Strict::String.meta(omittable: true)

    attribute :"Id",                             Types::Strict::String.meta(omittable: true)
    attribute :"SyncToken",                      Types::Strict::String.meta(omittable: true)
    attribute :"domain",                         Types::Strict::String.meta(omittable: true)
    attribute :"Vendor1099",                     Types::Bool.meta(omittable: true)

    attribute :"AcctNum",                        Types::Strict::String.meta(omittable: true)
    attribute :"CompanyName",                    Types::Strict::String.meta(omittable: true)
    attribute :"BillAddr",                       Qbo::Locations::Address.optional.meta(omittable: true)
    
    attribute :"WebAddr", Dry::Struct.meta(omittable: true) do
      attribute :"URI",                          Types::Strict::String.meta(omittable: true)
    end

    attribute :"PrimaryEmailAddr", Dry::Struct.meta(omittable: true) do
      attribute :"Address",                      Types::Strict::String.meta(omittable: true)
    end

    attribute :"PrimaryPhone", Dry::Struct.meta(omittable: true) do
      attribute :"FreeFormNumber",               Types::Strict::String.meta(omittable: true)
    end
    
    attribute :"sparse",                         Types::Bool.meta(omittable: true)
    attribute :"Active",                         Types::Bool.meta(omittable: true)
    attribute :"MetaData",                       Types::Hash.meta(omittable: true)

    attribute :"Balance",                        Types::Float.meta(omittable: true)
    attribute :"PrintOnCheckName",               Types::Strict::String.meta(omittable: true)

  end
end
