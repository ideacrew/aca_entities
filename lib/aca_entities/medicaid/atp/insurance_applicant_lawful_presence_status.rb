# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp InsuranceApplicantLawfulPresenceStatus
      class InsuranceApplicantLawfulPresenceStatus < Dry::Struct

        attribute :arrived_before_1996_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :immigration_documents, Types::Array.of(ImmigrationDocument).optional.meta(omittable: true)
        attribute :lawful_presence_status_eligibility, LawfulPresenceStatusEligibility.optional.meta(omittable: true)
        attribute :valid_date_range, StatusValidDateRange.optional.meta(omittable: true)
      end
    end
  end
end
