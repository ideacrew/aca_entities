# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        class MaximumRequest < Dry::Struct
          # @!attribute [r] request_id
          # A requester-assigned numeric ID that uniquely identifies the request
          # within a given message (both requests and responses)
          # 1-9 characters - numeric only
          # @return [String]
          attribute :request_id,
                    AcaEntities::Fdsh::Ifsv::H3::Types::RequestIDType.meta(
                      omittable: false
                    )

          # @!attribute [r] person_name
          # Applicant full name
          # @return [String]
          attribute :person_name,
                    AcaEntities::Fdsh::Person::PersonName.meta(omittable: false)

          # @!attribute [r] identification_id
          # Applicant SSN Identification
          # @return [String]
          attribute :identification_id,
                    AcaEntities::Fdsh::Types::FullyRestrictedSSNType.meta(
                      omittable: false
                    )

          # @!attribute [r] tax_filer_category_code
          # TaxFilerCategoryCode
          # @return [String]
          attribute :tax_filer_category_code,
                    AcaEntities::Fdsh::Ifsv::H3::Types::TaxFilerCategoryCodeKind
                      .meta(omittable: false)
        end
      end
    end
  end
end
