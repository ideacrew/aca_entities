# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          module Fti
            # Applicant Information
            class Response < Dry::Struct
              # @!attribute [r] ErrorMessage
              # A data type for Group of error messages
              # @return [String]
              attribute :ErrorMessage,
                        AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::ErrorMessage
                          .meta(omittable: false)

              # @!attribute [r] IRSResponse
              # A Response received from IRS
              # @return [String]
              attribute :IRSResponse,
                        AcaEntities::Fdsh::Ifsv::H9t::Api::Fti::IRSResponse
                          .meta(omittable: false)
            end
          end
        end
      end
    end
  end
end
