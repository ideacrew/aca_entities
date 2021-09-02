# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          module Fti
            # The group of information related to a IFSV applicant
            class Household < Dry::Struct
              # @!attribute [r] Income
              # Household Income Amount is the aggregate income of all individuals
              #   listed on the application and provided in the request to IRS.
              #   The household aggregate income includes a combined (joint) tax
              #   filer/spouse income if the tax filer/spouse filed a joint tax return              # @return [AcaEntities::Types::Money]
              attribute :Income,
                        AcaEntities::Types::Money.meta(omittable: false)

              # @!attribute [r] ApplicantVerification
              # A tax return filed by the household
              # @return [String]
              attribute :ApplicantVerification,
                        AcaEntities::Types::Array
                          .of(
                            AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Verification
                          ).meta(omittable: false)

              # @!attribute [r] DependentVerification
              # A tax return filed by the household
              # @return [String]
              attribute :DependentVerification,
                        AcaEntities::Types::Array
                          .of(
                            AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::Verification
                          ).meta(omittable: false)
            end
          end
        end
      end
    end
  end
end
