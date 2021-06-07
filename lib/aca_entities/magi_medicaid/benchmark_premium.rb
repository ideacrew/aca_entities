# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Canonical Vocabulary Entity for BenchmarkPremium.
    class BenchmarkPremium < Dry::Struct
      # @!attribute [r] monthly_slcsp_premium
      # Monthly Member Premium of the Second Lowest Cost Silver Plan of the applicant based on the age_of_applicant
      # For state Maine: If member aged above 19 then health-only SLCSP else health-and-dental SLCSP
      # @return [Money]
      attribute :monthly_slcsp_premium, Types::Money.meta(omittable: false)

      # @!attribute [r] monthly_lcsp_premium
      # Monthly Member Premium of the Lowest Cost Silver Plan of the applicant based on the age_of_applicant
      # @return [Money]
      attribute :monthly_lcsp_premium, Types::Money.meta(omittable: false)
    end
  end
end
