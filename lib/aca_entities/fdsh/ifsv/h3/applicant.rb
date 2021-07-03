# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        # Applicant Information
        class Applicant < Dry::Struct
          attribute :Person do
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
                      AcaEntities::Fdsh::Person::PersonSSNIdentification.meta(
                        omittable: false
                      )
          end

          # @!attribute [r] TaxFilerCategoryCode
          # A kind of tax filer
          # @return [String]
          attribute :TaxFilerCategoryCode,
                    AcaEntities::Fdsh::Ifsv::H3::Types::TaxFilerCategoryCodeKind
                      .meta(omittable: false)
        end
      end
    end
  end
end
