# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        # Applicant Information
        class FtiApplicant < Dry::Struct
          attribute :person do
            # @!attribute [r] person_name
            # A combination of names and/or titles by which a person is known
            # @return [String]
            attribute :person_name,
                      AcaEntities::Fdsh::Person::PersonName.meta(
                        omittable: false
                      )

            # @!attribute [r] person_ssn_identification
            # A unique reference to a living person; assigned by the United States Social Security Administration
            # @return [String]
            attribute :person_ssn_identification,
                      AcaEntities::Fdsh::Person::PersonSSNIdentification.meta(
                        omittable: false
                      )
          end

          # @!attribute [r] tax_filer_category_code
          # A kind of tax filer
          # @return [String]
          attribute :tax_filer_category_code,
                    AcaEntities::Fdsh::Ifsv::H9t::Types::TaxFilerCategoryCodeKind
                      .meta(omittable: true)

          attribute :fti_verifications,
                    Types::Array
                      .of(AcaEntities::Fdsh::Ifsv::H9t::FtiVerification)
                      .meta(omittable: true)
        end
      end
    end
  end
end
