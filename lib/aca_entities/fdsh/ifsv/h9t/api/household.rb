# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          # The group of information related to a IFSV applicant
          class Household < Dry::Struct
            # An amount of money received by the household in a particular year
            attribute :Income do
              # attribute :IncomeAmount
            end

            # A tax return filed by the household
            attribute :ApplicantVerification do
              attribute :TaxReturn,
                        AcaEntities::Fdsh::Ifsv::H9t::Api::TaxReturn.meta(
                          omittable: true
                        )
              attribute :ResponseMetadata,
                        AcaEntities::Fdsh::Ifsv::H9t::Api::ResponseMetadata
                          .meta(omittable: true)
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
end
