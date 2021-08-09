# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          # Request payload for FDSH Service:
          # Verify Annual Household Income and Family Size (Transactional) - IFSV
          class Request < Dry::Struct
            # @!attribute [r] RequestID
            # An HBX-assigned  numeric ID that uniquely identifies the request
            # within a given message (both requests and responses)
            # 1-9 characters - numeric only
            # @return [String]
            attribute :RequestID,
                      AcaEntities::Fdsh::Ifsv::H9t::Types::RequestIDType.meta(
                        omittable: false
                      )

            # @!attribute [r] IFSVApplicant
            # Applicant Information
            # @return [Hash]
            attribute :IFSVApplicants,
                      Types::Array
                        .of(AcaEntities::Fdsh::Ifsv::H9t::Api::IFSVApplicant)
                        .meta(omittable: false)
          end
        end
      end
    end
  end
end
