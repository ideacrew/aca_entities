# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Ifsv
        # Entity for RRV IFSV VerifyHouseholdIncomeBulkRequest
        class CompletePersonName < Dry::Struct
          # @!attribute [r] PersonGivenName
          # Applicant first name
          # @return [String]
          attribute :PersonFirstName, Types::String.meta(omittable: false)

          # @!attribute [r] PersonMiddleName
          # Applicant middle name or initial
          # @return [String]
          attribute :PersonMiddleName, Types::String.optional.meta(omittable: true)

          # @!attribute [r] PersonSurName
          # Applicant last name or family name
          # @return [String]
          attribute :PersonLastName, Types::String.meta(omittable: false)

          # @!attribute [r] PersonNameSuffixText
          # Applicant suffix text
          # @return [String]
          attribute :SuffixName, Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end