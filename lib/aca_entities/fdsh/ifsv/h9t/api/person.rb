# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          # Applicant Information
          class Person < Dry::Struct
            # @!attribute [r] PersonName
            # A combination of names and/or titles by which a person is known
            # @return [String]
            attribute :PersonName,
                      AcaEntities::Fdsh::Person::PersonName.meta(
                        omittable: false
                      )

            # @!attribute [r] PersonSSNIdentification
            # A unique reference to a living person; assigned by the United States Social Security Administration
            # @return [String]
            attribute :PersonSSNIdentification,
                      AcaEntities::Fdsh::Person::PersonSsnIdentification.meta(
                        omittable: false
                      )
          end
        end
      end
    end
  end
end
