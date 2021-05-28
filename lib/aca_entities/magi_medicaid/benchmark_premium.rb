# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Canonical Vocabulary Entity for BenchmarkPremium.
    class BenchmarkPremium < Dry::Struct
      # @!attribute [r] slcsp_premium
      # Member Premium of the Second Lowest Cost Silver Plan of the applicant based on the age_of_applicant
      # For state Maine: If member aged above 19 then health-only SLCSP else health-and-dental SLCSP
      # @return [Money]
      attribute :slcsp_premium, Types::Money.meta(omittable: false)

      # @!attribute [r] lcsp_premium
      # Member Premium of the Lowest Cost Silver Plan of the applicant based on the age_of_applicant
      # @return [Money]
      attribute :lcsp_premium, Types::Money.meta(omittable: false)
    end
  end
end
