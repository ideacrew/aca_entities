# frozen_string_literal: true

module AcaEntities
  module Policies
    # entity for policy
    class Policy < Dry::Struct
      attribute :policy_id,               Types::String
      attribute :enrollment_group_id,     Types::String.meta(omittable: false)
      # hios_plan_id
      attribute :qhp_id,                 Types::String.optional.meta(omittable: true)
      attribute :allocated_aptc,         Types::Float.optional.meta(omittable: true)
      attribute :elected_aptc,           Types::Float.optional.meta(omittable: true)
      attribute :applied_aptc,           Types::Float.optional.meta(omittable: true)
      attribute :csr_amt,                Types::Float.optional.meta(omittable: true)
      attribute :total_premium_amount,   Types::Float.meta(omittable: false)
      attribute :total_responsible_amount,  Types::Float.meta(omittable: false)
      attribute :coverage_kind,          Types::String.meta(omittable: false)
      attribute :term_for_np,            Types::Bool.optional.meta(omittable: true)
      attribute :rating_area,            Types::String.optional.meta(omittable: false)
      attribute :service_area,           Types::String.optional.meta(omittable: true)

      attribute :last_maintenance_date, Types::Date.optional.meta(omittable: true)
      attribute :last_maintenance_time, Types::String.optional.meta(omittable: true)
      attribute :aasm_state,           Types::String.meta(omittable: true)
      # policy subscriber id
      attribute :exchange_subscriber_id, Types::String.optional.meta(omittable: true)
      # policy effectuation status canceled or resubmitted
      attribute :effectuation_status, Types::String.optional.meta(omittable: true)
      # policy plan coverage type health or dental
      attribute :insurance_line_code,   Types::String.optional.meta(omittable: true)
      # fetch this from policy plan hios_id
      attribute :csr_variant,           Types::String.optional.meta(omittable: true)
      attribute :enrollees,             Types::Array.of(AcaEntities::Enrollees::Enrollee).meta(omittable: false)
      # attribute :aptc_maximums,     Types::Array.of(AcaEntities::Policies::AptcMaximum)
      #                                          .optional.meta(omittable: true)
      # attribute :aptc_credits,     Types::Array.of(AcaEntities::Policies::AptcCredit)
      #                                          .optional.meta(omittable: true)

      def primary_subscriber
        return if enrollees.blank?

        enrollees.detect do |enrollee|
          enrollee.is_subscriber == true
        end
      end

      def responsible_party_subscriber
        return if enrollees.blank?

        enrollees.detect do |enrollee|
          enrollee.is_responsible_party == true
        end
      end
    end
  end
end
