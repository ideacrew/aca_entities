# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for DhsSave.
      class DhsSave < Dry::Struct

        attribute :class_of_admission_code,       Types::String.optional.meta(omittable: true)
        attribute :admission_end_date,            Types::Date.optional.meta(omittable: true)

        # VerificationGroup attributes
        attribute :save_step,                     Types::String.optional.meta(omittable: true)
        attribute :case_nbr,                      Types::String.optional.meta(omittable: true)
        attribute :eligibility_statement_code,    Types::String.optional.meta(omittable: true)
        attribute :lawful_presence_verified_code, Types::String.optional.meta(omittable: true)
        attribute :five_year_bar_code,            Types::String.optional.meta(omittable: true)
        attribute :qualified_non_citizen_code,    Types::String.optional.meta(omittable: true)
        attribute :five_year_bar_met_code,        Types::String.optional.meta(omittable: true)
        attribute :us_citizen_code,               Types::String.optional.meta(omittable: true)
        attribute :grant_date,                    Types::String.optional.meta(omittable: true)
        attribute :g_845_major_cd,                Types::String.optional.meta(omittable: true)
        attribute :dhs_comments,                  Types::String.optional.meta(omittable: true)
      end
    end
  end
end
