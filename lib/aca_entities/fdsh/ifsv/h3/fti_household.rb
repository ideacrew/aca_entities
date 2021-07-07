# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        # The group of information related to a IFSV applicant
        class FtiHousehold < Dry::Struct
          # An amount of money received by the household in a particular year
          attribute :Income do
            # attribute :IncomeAmount
          end

          # A tax return filed by the household
          attribute :ApplicantVerification do
            attribute :FtiTaxReturn,
                      AcaEntities::Fdsh::Ifsv::H3::FtiTaxReturn.meta(
                        omittable: true
                      )
            attribute :FtiResponseMetadata,
                      AcaEntities::Fdsh::Ifsv::H3::FtiResponseMetadata.meta(
                        omittable: true
                      )
          end

          attribute :DependentVerification do
            attribute :TaxReturn, Types::String
            attribute :ResponseMetadata, Types::String
          end
        end
      end
    end
  end
end
