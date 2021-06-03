# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        module Requests
          # Request payload for FDSH Service:
          # Verify Annual Household Income and Family Size (Transactional) - IFSV
          class Request
            # @!attribute [r] RequestID
            # An HBX-assigned  numeric ID that uniquely identifies the request
            # within a given message (both requests and responses)
            # 1-9 characters - numeric only
            # @return [String]
            attribute :"RequestID",
                      Types::Fdsh::Ifsv::H3::RequestIDType.meta(
                        omittable: false
                      )

            # @!attribute [r] PersonSSNIdentification
            # Person SSN Identification
            # @return [String]
            attribute :"PersonSSNIdentification",
                      Types::Fdsh::Ifsv::H3::FullyRestrictedSSNType.meta(
                        omittable: false
                      )

            # @!attribute [r] PersonGivenName
            # Applicant first name
            # @return [String]
            attribute :"PersonGivenName", Types::String.meta(omittable: false)

            # @!attribute [r] PersonMiddleName
            # Person Middle Name or Initial
            # @return [String]
            attribute :"PersonMiddleName",
                      Types::String.optional.meta(omittable: true)

            # @!attribute [r] PersonSurName
            # Applicant last name
            # @return [String]
            attribute :"PersonSurName", Types::String.meta(omittable: false)

            # @!attribute [r] TaxFilerCategoryCode
            # TaxFilerCategoryCode
            # @return [String]
            attribute :"TaxFilerCategoryCode",
                      Types::Fdsh::Ifsv::H3::TaxFilerCategoryCodeType.meta(
                        omittable: false
                      )
          end
        end
      end
    end
  end
end
