# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      class EligibilityResponse < Dry::Struct

        # @!attribute [r] determination_date
        # Tthe date the request was made.  YYYY-MM-DD
        # @return [Date]
        attribute :determination_date,  Types::Date.meta(omittable: false)

        # @!attribute [r] applicants
        # The list of {Applicants} whose eligibility is determined
        # @return [Array<Applicant>]
        attribute :applicants,          Types::Array.of(Applicant).meta(omittable: false)

      end
    end
  end
end
