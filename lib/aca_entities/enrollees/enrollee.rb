# frozen_string_literal: true

module AcaEntities
    module Enrollees
      # entity for enrollee
      class Enrollee < Dry::Struct
        attribute :enrollee_demographics,
                  AcaEntities::Enrollees::EnrolleeDemographics.meta(omittable: false)
        attribute :hbx_member_id,    Types::String.optional.meta(omittable: true)
        attribute :pre_amt,          Types::Decimal.optional.meta(omittable: true)
        attribute :coverage_start,   Types::Date.optional.meta(omittable: true)
        attribute :coverage_end,     Types::Date.optional.meta(omittable: true)
        attribute :coverage_status,  Types::String.optional.meta(omittable: true)
        attribute :relationship_status_code, Types::String.meta(omittable: false)
        attribute :issuer_assigned_member_id, Types::String.meta(omittable: false)
        attribute :issuer_assigned_policy_id, Types::String.meta(omittable: false)
        attribute :addresses,
                  Types::Array
                      .of(AcaEntities::Locations::Address)
                      .optional
                      .meta(omittable: true)
        attribute :emails,
                  Types::Array
                      .of(AcaEntities::Contacts::EmailContact)
                      .optional
                      .meta(omittable: true)
        attribute :phones,
                  Types::Array
                      .of(AcaEntities::Contacts::PhoneContact)
                      .optional
                      .meta(omittable: true)
        attribute :segments,
                  Types::Array
                     .of(AcaEntities::Enrollees::Segment)
                     .optional
                     .meta(omittable: true)
  
      end
    end
  end
  