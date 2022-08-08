# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    # Benefit Sponsor Subject shall be used for benefit sponsors eligibilities
    class BenefitSponsorSubject < Dry::Struct
      # @!attribute [r] fein
      # Benefit sponsor fein
      # @return [String]
      attribute :fein, Types::String.meta(omittable: false)

      # @!attribute [r] fein
      # Benefit sponsor legal name
      # @return [String]
      attribute :legal_name, Types::String.meta(omittable: false)

      # @!attribute [r] fein
      # benefit sponsorship id reference of the benefit sponsor
      # @return [String]
      attribute :benefit_sponsorship_id, Types::String.meta(omittable: false)
    end
  end
end
