# frozen_string_literal: true

module AcaEntities
  module Organizations
    class BrokerAgencyProfileReference < Dry::Struct
      attribute :hbx_id,                            Types::String.meta(omittable: false)
      attribute :market_kind,                       Types::BrokerMarketKind.meta(omittable: false)
      attribute :name,                              Types::String.meta(omittable: false)
      attribute :dba,                               Types::String.optional.meta(omittable: true)
      attribute :display_name,                      Types::String.optional.meta(omittable: true)
      attribute :fein,                              Types::String.meta(omittable: true)
      attribute :corporate_npn,                     Types::String.optional.meta(omittable: true)
    end
  end
end