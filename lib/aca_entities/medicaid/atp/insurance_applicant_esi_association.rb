# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp Insurance Applicant ESI Association
      class InsuranceApplicantEsiassociation < Dry::Struct

        attribute :eligible_indicator, Types::Bool.meta(omittable: false)
        attribute :enrolled_indicator, Types::Bool.meta(omittable: false)
        attribute :eligibility_unknown_indicator, Types::Bool.meta(omittable: false)
      end
    end
  end
end
