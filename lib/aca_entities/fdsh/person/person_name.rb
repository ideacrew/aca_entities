# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Person
      # A data type for a combination of names and/or titles by which a person is known
      class PersonName < Dry::Struct
        # @!attribute [r] PersonGivenName
        # Applicant first name
        # @return [String]
        attribute :PersonGivenName, Types::String.meta(omittable: false)

        # @!attribute [r] PersonMiddleName
        # Applicant middle name or initial
        # @return [String]
        attribute :PersonMiddleName, Types::String.optional.meta(omittable: true)

        # @!attribute [r] PersonSurName
        # Applicant last name or family name
        # @return [String]
        attribute :PersonSurName, Types::String.meta(omittable: false)
      end
    end
  end
end
