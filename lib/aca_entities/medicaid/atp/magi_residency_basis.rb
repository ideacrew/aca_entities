# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp MagiResidencyBasis
      class MagiResidencyBasis < Dry::Struct

        attribute :status_code,                     Types::String.meta(omittable: false)
        attribute :status_indicator,                Types::Bool.optional.meta(omittable: true)
        attribute :ineligibility_reason,            Types::String.optional.meta(omittable: true)
        attribute :determination_date,              Types::DateTime.optional.meta(omittable: true)
        attribute :pend_reason,                     Types::String.optional.meta(omittable: true)
        attribute :student_residency_rule_applies,  Types::Bool.optional.meta(omittable: true)
        attribute :medicaid_correct_state,          Types::Bool.optional.meta(omittable: true)

      end
    end
  end
end
