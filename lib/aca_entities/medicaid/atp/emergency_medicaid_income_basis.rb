# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp EmergencyMedicaidIncomeBasis
      class EmergencyMedicaidIncomeBasis < Dry::Struct

        attribute :medicaid_status_code,                  Types::String.meta(omittable: false)
        attribute :medicaid_status_indicator,             Types::Bool.optional.meta(omittable: true)
        attribute :medicaid_inconsistency_reason,         Types::String.optional.meta(omittable: true)
        attribute :medicaid_ineligibility_reason,         Types::String.optional.meta(omittable: true)
        attribute :medicaid_status_determination_date,    Types::DateTime.optional.meta(omittable: true)
      end
    end
  end
end
