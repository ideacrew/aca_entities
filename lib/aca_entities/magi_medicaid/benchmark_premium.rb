# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Canonical Vocabulary Entity for BenchmarkPremium.
    # All the attributes represent monthly premiums
    class BenchmarkPremium < Dry::Struct
      # @!attribute [r] lcsp_premiums
      # Monthly Member Premium of the Lowest Cost Silver Plan of the applicant based on the age_of_applicant
      # @return [Array<AcaEntities::MagiMedicaid::MemberPremium>]
      attribute :lcsp_premiums, Types::Array.of(AcaEntities::MagiMedicaid::MemberPremium)

      # @!attribute [r] health_only_slcsp_premiums
      # Monthly Member Premium of the Second Lowest Cost Silver Plan of
      # the applicant based on the age_of_applicant for the health(default) benchmark_product_model
      # @return [Array<AcaEntities::MagiMedicaid::MemberPremium>]
      attribute :health_only_slcsp_premiums, Types::Array.of(AcaEntities::MagiMedicaid::MemberPremium)

      # @!attribute [r] health_and_dental_slcsp_premiums
      # Monthly Member Premium of the Second Lowest Cost Silver Plan of
      # the applicant based on the age_of_applicant for the health_and_dental benchmark_product_model
      # This is default slcsp_premium
      # @return [Array<AcaEntities::MagiMedicaid::MemberPremium>]
      attribute :health_and_dental_slcsp_premiums, Types::Array.of(AcaEntities::MagiMedicaid::MemberPremium).optional.meta(omittable: true)

      # @!attribute [r] health_and_ped_dental_slcsp_premiums
      # Monthly Member Premium of the Second Lowest Cost Silver Plan of
      # the applicant based on the age_of_applicant for the default benchmark_product_model
      # This is default slcsp_premium
      # @return [Array<AcaEntities::MagiMedicaid::MemberPremium>]
      attribute :health_and_ped_dental_slcsp_premiums, Types::Array.of(AcaEntities::MagiMedicaid::MemberPremium).optional.meta(omittable: true)
    end
  end
end
