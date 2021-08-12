# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          # Applicant Information
          class IFSVApplicant < Dry::Struct
            # @!attribute [r] Person
            # An applicant's identifying information
            # @return [String]
            attribute :Person,
                      AcaEntities::Fdsh::Ifsv::H9t::Api::Person.meta(
                        omittable: false
                      )

            # @!attribute [r] TaxFilerCategoryCode
            # A kind of tax filer
            # @return [String]
            attribute :TaxFilerCategoryCode,
                      AcaEntities::Fdsh::Ifsv::H9t::Types::TaxFilerCategoryCodeKind
                        .meta(omittable: false)
          end
        end
      end
    end
  end
end
