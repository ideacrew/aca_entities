# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module H79
        module Ifsv
          module Operations
            # convert Application entity to request
            class CreateRrvIfsvRequest
              include Dry::Monads[:result, :do, :try]

              def call(applications)
                payload = yield construct_ifsv_request(applications)
                validated_payload = yield validate_payload(payload)
                request_entity = yield ifsv_request_entity(validated_payload)

                Success(request_entity)
              end

              private

              def validate_payload(payload)
                result = AcaEntities::Fdsh::Rrv::Ifsv::VerifyHouseholdIncomeBulkRequestContract.new.call(payload)
                result.success? ? Success(result) : Failure("Invalid IFSV due to #{result.errors.to_h}")
              end

              def ifsv_request_entity(payload)
                Success(AcaEntities::Fdsh::Rrv::Ifsv::VerifyHouseholdIncomeBulkRequest.new(payload.to_h))
              end

              def construct_ifsv_request(applications)
                request_groups = applications.collect do |application|
                  construct_applicant_request_group(application)
                end

                request = {
                  IFSVApplicantRequestGrps: request_groups
                }

                Success(request)
              end

              def construct_applicant_request_group(application)
                {
                  RequestId: application.hbx_id,
                  IFSVApplicants: construct_applicant_request(application)
                }
              end

              def construct_applicant_request(application)
                application.applicants.collect do |applicant|
                  next unless applicant.identifying_information.encrypted_ssn.present?
                  {
                    TaxpayerIdentificationNumber: decrypt_ssn(applicant.identifying_information&.encrypted_ssn),
                    CompletePersonName: construct_person_name(applicant.name),
                    FilerTypeCd: fetch_tax_filing_code(application, applicant)
                  }
                end
              end

              def fetch_tax_filing_code(application, applicant)
                return "PRIMARY" if applicant.is_primary_applicant
                relationship_kind = fetch_relationship_kind(application, applicant)
                if relationship_kind == "spouse"
                  "SPOUSE"
                else
                  "DEPENDENT"
                end
              end

              def construct_person_name(applicant_name)
                return nil unless applicant_name
                {
                  PersonFirstName: applicant_name.first_name,
                  PersonMiddleName: applicant_name.middle_name,
                  PersonLastName: applicant_name.last_name,
                  SuffixName: applicant_name.name_sfx
                }
              end

              def fetch_relationship_kind(application, applicant)
                relationship = application.relationships.detect {|rel| rel.applicant_reference.person_hbx_id == applicant.person_hbx_id }
                relationship&.kind
              end

              def decrypt_ssn(encrypted_ssn)
                AcaEntities::Operations::Encryption::Decrypt.new.call({ value: encrypted_ssn }).value!
              end
            end
          end
        end
      end
    end
  end
end