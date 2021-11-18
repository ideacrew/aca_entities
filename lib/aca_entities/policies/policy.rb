# frozen_string_literal: true

module AcaEntities
  module Policies
    # entity for policy
    class Policy < Dry::Struct
      attribute :policy_id,               Types::Bson
      attribute :eg_id,                  Types::String.optional.meta(omittable: true)
      # hios_plan_id
      attribute :qhp_id,                 Types::String.optional.meta(omittable: true)
      attribute :allocated_aptc,         Types::Decimal.optional.meta(omittable: true)
      attribute :elected_aptc,           Types::Decimal.optional.meta(omittable: true)
      attribute :applied_aptc,           Types::Decimal.optional.meta(omittable: true)
      attribute :csr_amt,                Types::Decimal.optional.meta(omittable: true)
      attribute :pre_amt_tot,            Types::Decimal.optional.meta(omittable: true)
      attribute :tot_res_amt,            Types::Decimal.optional.meta(omittable: true)
      attribute :kind,                   Types::String.optional.meta(omittable: true)
      attribute :term_for_np,            Types::Bool.optional.meta(omittable: true)
      attribute :rating_area,            Types::String.optional.meta(omittable: true)
      attribute :service_area,           Types::String.optional.meta(omittable: true)

      attribute :last_maintenance_date, Types::Date.optional.meta(omittable: true)
      attribute :last_maintenance_time, Types::String.optional.meta(omittable: true)
      # policy subscriber id
      attribute :exchange_subscriber_id, Types::String.optional.meta(omittable: true)
      # policy effectuation status canceled or resubmitted
      attribute :effectuation_status, Types::Bool.optional.meta(omittable: true)
      # policy plan coverage type health or dental
      attribute :insurance_line_code,   Types::String.optional.meta(omittable: true)
      # fetch this from policy plan hios_id
      attribute :csr_variant,           Types::String.optional.meta(omittable: true)
      attribute :enrollees,              Types::Array.of(AcaEntities::Enrollees::Enrollee).optional.meta(omittable: true)
      attribute :aptc_maximums,     Types::Array.of(AcaEntities::Policies::AptcMaximum)
                                               .optional.meta(omittable: true)
      attribute :aptc_credits,     Types::Array.of(AcaEntities::Policies::AptcCredit)
                                               .optional.meta(omittable: true)
    end
  end
end
