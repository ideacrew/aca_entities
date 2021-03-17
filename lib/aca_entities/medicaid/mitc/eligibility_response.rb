# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Mitc
      class EligibilityResponse < Dry::Struct

        # @!attribute [r] determination_date
        # Tthe date the request was made.  YYYY-MM-DD
        # @return [String]
        attribute :determination_date,  Types::String.meta(omittible: false)

        # @!attribute [r] applicants
        # The list of {Applicants} whose eligibility is determined
        # @return [Array<Applicant>]
        attribute :applicants,          Types::Array.of(Applicant).meta(omittible: false)

      end
    end
  end
end
