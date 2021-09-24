# frozen_string_literal: true

module AcaEntities
  module Brokers
    class BrokerAccount < Dry::Struct

      attribute :start_on,                      Types::Date.meta(omittable: false)
      attribute :end_on,                        Types::Date.optional.meta(omittable: true)
      attribute :is_active,                     Types::Bool.meta(omittable: true)
      attribute :broker_role_reference,         AcaEntities::Brokers::BrokerRoleReference.meta(omittable: false)
      attribute :broker_agency_reference,       AcaEntities::Organizations::BrokerAgencyProfileReference.meta(omittable: false)
      attribute :updated_by,                    AcaEntities::People::PersonReference.optional.meta(omittable: true)
    end
  end
end



