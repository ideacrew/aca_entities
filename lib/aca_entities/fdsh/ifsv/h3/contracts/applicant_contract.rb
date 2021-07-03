# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        module Contracts
          # FDSH schema and validation rules for {AcaEntities::Fdsh::Person::PersonName}
          class ApplicantContract < Contract
            # @!method call(opts)
            # @param opts [Hash] the parameters to validate using this contract
            # @option opts [RequestIDType] :request_id A requester-assigned numeric ID that uniquely identifies the request
            # @option opts [AcaEntities::Fdsh::Person::PersonName] :person_name Applicant's full name
            # @option opts [FullyRestrictedSSNType] :identification_id Applicant last name
            # @option opts [TaxFilerCategoryCodeType] :tax_filer_category_code Applicant's income tax filing role
            params do
              required(:request_id).filled(
                AcaEntities::Fdsh::Ifsv::H3::Types::RequestIDType
              )

              # required(:person_name).filled(
              #   AcaEntities::Fdsh::Person::PersonName
              # )
              required(:identification_id).filled(
                AcaEntities::Fdsh::Ifsv::H3::Types::FullyRestrictedSSNType
              )
              required(:tax_filer_category_code).filled(
                AcaEntities::Fdsh::Ifsv::H3::Types::TaxFilerCategoryCodeKind
              )
            end
          end
        end
      end
    end
  end
end
