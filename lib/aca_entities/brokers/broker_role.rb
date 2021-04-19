# frozen_string_literal: true

module AcaEntities
  module Brokers
    class BrokerRole < Dry::Struct

      attribute :aasm_state,                          Types::String.meta(omittable: false)
      attribute :npn,                                 Types::String.meta(omittable: false)
      attribute :provider_kind,                       Types::ProviderKinds.optional.meta(omittable: false)
      attribute :reason,                              Types::String.optional.meta(omittable: true)
      attribute :market_kind,                         Types::String.meta(omittable: false)
      attribute :languages_spoken,                    Types::Array.optional.meta(omittable: true)
      attribute :working_hours,                       Types::Bool.optional.meta(omittable: true)
      attribute :accept_new_clients,                  Types::Bool.optional.meta(omittable: true)
      attribute :license,                             Types::Bool.optional.meta(omittable: true)
      attribute :training,                            Types::Bool.optional.meta(omittable: true)
      attribute :carrier_appointments,                Types::Hash.optional.meta(omittable: true)
      attribute :broker_agency_reference,             AcaEntities::Organizations::BrokerAgencyProfileReference.meta(omittable: false)
    end
  end
end