# frozen_string_literal: true

module AcaEntities
  module Enrollees
    # entity for enrollee
    class Enrollee < Dry::Struct
      attribute :enrollee_demographics,
                AcaEntities::Enrollees::EnrolleeDemographics.meta(omittable: false)
      attribute :first_name, Types::String.meta(omittable: false)
      attribute :middle_name, Types::String.optional.meta(omittable: true)
      attribute :last_name, Types::String.meta(omittable: false)
      attribute :name_suffix, Types::String.optional.meta(omittable: true)
      attribute :hbx_member_id,    Types::String.meta(omittable: false)
      attribute :premium_amount,   Types::Float.meta(omittable: false)
      attribute :coverage_start,   Types::Date.meta(omittable: false)
      attribute :coverage_end,     Types::Date.optional.meta(omittable: true)
      attribute :coverage_status,  Types::String.optional.meta(omittable: true)
      attribute :relationship_status_code, Types::String.meta(omittable: false)
      attribute :issuer_assigned_member_id, Types::String.optional.meta(omittable: true)
      attribute :issuer_assigned_policy_id, Types::String.optional.meta(omittable: true)
      attribute :is_subscriber, Types::Bool.meta(omittable: false)
      attribute :is_responsible_party, Types::Bool.meta(omittable: false)
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

      def residential_address
        return if addresses.blank?

        addresses.detect do |address|
          address.kind == 'home'
        end
      end

      def mailing_address
        return if addresses.blank?

        addresses.detect do |address|
          address.kind == 'mailing'
        end
      end

      def home_phone
        return if phones.blank?

        phones.detect do |phone|
          phone.kind == 'home'
        end
      end
    end
  end
end
