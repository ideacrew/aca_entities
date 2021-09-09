# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Operations
          # convert person entity to initial request
          class IfsvVerificationRequest
            include Dry::Monads[:result, :do, :try]

            def call(application)
              payload = yield construct_ifsv_request(application)
              validated_payload = yield validate_payload(payload)
              request_entity = yield ifsv_request_entity(validated_payload)

              Success(request_entity)
            end

            private

            def validate_payload(payload)
              result = AcaEntities::Fdsh::Ifsv::H9t::Contracts::Api::RequestContract.new.call(payload)
              result.success? ? Success(result) : Failure("Invalid IFSV due to #{result.errors.to_h}")
            end

            def ifsv_request_entity(payload)
              Success(AcaEntities::Fdsh::Ifsv::H9t::Api::Request.new(payload.to_h))
            end

            def construct_ifsv_request(application)
              request = {
                RequestID: application.hbx_id,
                IFSVApplicants: construct_ifsv_applicant_request(application)
              }

              Success(request)
            end

            def construct_ifsv_applicant_request(application)
              application.applicants.collect do |applicant|
                next unless applicant.identifying_information.ssn.present?
                {
                  Person: construct_request_person(applicant),
                  TaxFilerCategoryCode: fetch_tax_filing_code(application, applicant)
                }
              end
            end

            def construct_request_person(applicant)
              {
                PersonName: construct_person_name(applicant.name),
                PersonSSNIdentification: { IdentificationID: applicant.identifying_information&.ssn }
              }
            end

            def fetch_tax_filing_code(application, applicant)
              relationship_kind = fetch_relationship_kind(application, applicant)
              if applicant.is_primary_applicant
                "PRIMARY"
              elsif relationship_kind == "spouse"
                "SPOUSE"
              else
                "DEPENDENT"
              end
            end

            def construct_person_name(applicant_name)
              {
                PersonGivenName: applicant_name&.first_name,
                PersonMiddleName: applicant_name&.middle_name,
                PersonSurName: applicant_name&.last_name
              }
            end

            def fetch_relationship_kind(application, applicant)
              relationship = application.relationships.detect {|rel| rel.applicant_reference.person_hbx_id == applicant.person_hbx_id }
              relationship&.kind
            end
          end
        end
      end
    end
  end
end