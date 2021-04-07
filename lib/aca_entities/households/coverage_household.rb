# frozen_string_literal: true

module AcaEntities
  module Households
    class CoverageHousehold < Dry::Struct

      attribute :start_date,                            Types::Date.meta(omittable: false)
      attribute :end_date,                              Types::Date.meta(omittable: false)
      attribute :is_immediate_family,                   Types::Bool.optional.meta(omittable: false)
      attribute :is_determination_split_household,      Types::Bool.optional.meta(omittable: false)
      attribute :submitted_at,                          Types::Bool.optional.meta(omittable: false)
      attribute :aasm_state,                            Types::Bool.optional.meta(omittable: false)
      attribute :coverage_household_members,            Types::Strict::Array.of(AcaEntities::Households::CoverageHouseholdMember).meta(omittable: false)
      attribute :broker_agency,                         AcaEntities::Organizations::BrokerAgencyProfileReference.optional.meta(omittable: true)
      attribute :broker_role,                           AcaEntities::Brokers::BrokerRoleReference.optional.meta(omittable: true)
    end
  end
end
