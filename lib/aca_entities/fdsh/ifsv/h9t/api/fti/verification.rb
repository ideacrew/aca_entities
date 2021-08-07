# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          module Fti
            # A tax return filed by the household
            class Verification < Dry::Struct
              # @!attribute [r] TaxReturn
              # Applicant tax return information
              # @return [AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::TaxReturn]
              attribute :TaxReturn,
                        AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::TaxReturn

              # @!attribute [r] ResponseMetadata
              # Metadata about a response
              # @return [String]
              attribute :ResponseMetadata,
                        AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::ResponseMetadata
                          .meta(omittable: false)
            end
          end
        end
      end
    end
  end
end
