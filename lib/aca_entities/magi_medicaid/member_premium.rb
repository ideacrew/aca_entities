# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Canonical Vocabulary Entity for BenchmarkPremium.
    # All the attributes represent monthly premiums
    class MemberPremium < Dry::Struct
      # @!attribute [r] member_identifier
      # Member Identifier
      # @return [String]
      attribute :member_identifier, Types::String

      # @!attribute [r] monthly_premium
      # Monthly Member Premium of the Second Lowest Cost Silver Plan of
      # the applicant based on the age_of_applicant
      # @return [Money]
      attribute :monthly_premium, Types::Money
    end
  end
end
