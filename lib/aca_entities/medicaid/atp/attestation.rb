# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp attestation
      class Attestation < Dry::Struct
        attribute :is_incarcerated,  Types::Bool.optional.meta(omittable: true)
        attribute :privacy_policy_agreement_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :attested_not_incarcerated_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :pending_disposition, Types::String.optional.meta(omittable: true)
        attribute :attested_if_information_changes_indicator, Types::Bool
        attribute :attested_medicaid_applicant_awareness_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :attested_non_perjury_indicator, Types::Bool
        attribute :attested_to_cooperate_with_medical_collection_agency, Types::Bool.optional.meta(omittable: true)
        attribute :tax_return_access_indicator, Types::Bool
        attribute :tax_return_access, Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
