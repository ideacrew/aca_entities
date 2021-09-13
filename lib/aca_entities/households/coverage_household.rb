# frozen_string_literal: true

module AcaEntities
  module Households
    class CoverageHousehold < Dry::Struct

      attribute :start_date,                            Types::Date.optional.meta(omittable: true)
      attribute :end_date,                              Types::Date.optional.meta(omittable: true)
      attribute :is_immediate_family,                   Types::Bool.meta(omittable: false)
      attribute :is_determination_split_household,      Types::Bool.optional.meta(omittable: true)
      attribute :submitted_at,                          Types::Date.optional.meta(omittable: true)
      attribute :aasm_state,                            Types::String.optional.meta(omittable: true)
      attribute :coverage_household_members,
                Types::Strict::Array.of(AcaEntities::Households::CoverageHouseholdMember).optional.meta(omittable: false)
      attribute :broker_agency_reference,
                AcaEntities::Organizations::BrokerAgencyProfileReference.optional.meta(omittable: true)
      attribute :broker_role_reference,                           AcaEntities::Brokers::BrokerRoleReference.optional.meta(omittable: true)
    end
  end
end
