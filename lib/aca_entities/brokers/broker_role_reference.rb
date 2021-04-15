# frozen_string_literal: true

module AcaEntities
  module Brokers
    class BrokerRoleReference < Dry::Struct
      attribute :npn,                       Types::String.meta(omittable: false)
      attribute :person_reference,          AcaEntities::People::PersonReference.meta(omittable: false)
      attribute :broker_agency_reference,   AcaEntities::Organizations::BrokerAgencyProfileReference.meta(omittable: false)
    end
  end
end