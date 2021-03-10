# frozen_string_literal: true

module AcaEntities
  module Eligibility
    class MagiIncomeBasis < Dry::Struct

      attribute :medicaid_status_code,                  Types::String.meta(omittable: false)
      attribute :medicaid_status_indicator,             Types::Bool.optional.meta(omittable: true)
      attribute :medicaid_inconsistency_reason,         Types::String.optional.meta(omittable: true)
      attribute :medicaid_ineligibility_reason,         Types::String.optional.meta(omittable: true)
      attribute :medicaid_status_determination_date,    Types::Date.optional.meta(omittable: true)

      attribute :income_verified_data_source,           Types::String.optional.meta(omittable: true) # TBD
      attribute :annual_income_verification_status,     Types::Bool.optional.meta(omittable: true)
      attribute :annual_income_inconsistency_reason,    Types::String.optional.meta(omittable: true)
      attribute :annual_income_determination_date,      Types::Date.optional.meta(omittable: true)
      attribute :annual_income_verification_source,     Types::String.optional.meta(omittable: true)
      attribute :income_eligible_under_rpc,             Types::Bool.optional.meta(omittable: true)
      attribute :applicable_medicaid_standard,          Types::Integer.optional.meta(omittable: true)

    end
  end
end
