# frozen_string_literal: true

module AcaEntities
  module GeneralAgencies
    class GeneralAgencyAccount < Dry::Struct

      attribute :start_on,                      Types::Date.meta(omittable: false)
      attribute :end_on,                        Types::Date.optional.meta(omittable: false)
      attribute :is_active,                     Types::Bool.optional.meta(omittable: false)
      attribute :aasm_state,                    Types::String.optional.meta(omittable: false)
      attribute :general_agency_reference,      AcaEntities::Organizations::GeneralAgencyReference.meta(omittable: false)
      attribute :broker_role_reference,         AcaEntities::Brokers::BrokerRoleReference.optional.meta(omittable: true)
      attribute :updated_by,                    AcaEntities::People::PersonReference.optional.meta(omittable: true)
    end
  end
end
