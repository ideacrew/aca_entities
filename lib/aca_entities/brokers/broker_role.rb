# frozen_string_literal: true

module AcaEntities
  module Brokers
    class BrokerRole < Dry::Struct

      attribute :aasm_state,                          Types::String.optional.meta(omittable: false)
      attribute :npn,                                 Types::String.optional.meta(omittable: false)
      attribute :provider_kind,                       Types::String.optional.meta(omittable: false)
      attribute :reason,                              Types::String.optional.meta(omittable: false)
      attribute :market_kind,                         Types::String.optional.meta(omittable: false)
      attribute :languages_spoken,                    Types::Array.optional.meta(omittable: false)
      attribute :working_hours,                       Types::Bool.optional.meta(omittable: false)
      attribute :accept_new_clients,                  Types::Bool.optional.meta(omittable: false)
      attribute :license,                             Types::Bool.optional.meta(omittable: false)
      attribute :training,                            Types::Bool.optional.meta(omittable: false)
      attribute :carrier_appointments,                Types::Hash.optional.meta(omittable: false)
      attribute :broker_agency,                       AcaEntities::Brokers::BrokerAgencyReference.meta(omittable: false)
    end
  end
end