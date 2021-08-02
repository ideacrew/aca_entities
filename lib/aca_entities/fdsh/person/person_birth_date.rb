# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Person
      # A data type for a combination of names and/or titles by which a person is known
      class PersonBirthDate < Dry::Struct
        # @!attribute [r] Date
        # Applicant date of birth
        # @return [String]
        attribute :Date,                    Types::Strict::Date.meta(omittable: false)
      end
    end
  end
end
