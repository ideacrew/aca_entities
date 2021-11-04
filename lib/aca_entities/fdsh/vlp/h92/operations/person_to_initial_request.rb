# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        module Operations
          # convert person entity to initial request
          class PersonToInitialRequest
            include Dry::Monads[:result, :do, :try]

            def call(params)
              payload = yield construct_initial_request(params)
              validated_payload = yield validate_payload(payload)
              request_entity = yield initial_verification_request_entity(validated_payload)

              Success(request_entity)
            end

            private

            def validate_payload(payload)
              result = AcaEntities::Fdsh::Vlp::H92::InitialVerificationRequestContract.new.call(payload)
              result.success? ? Success(result) : Failure("Invalid verificattion request due to #{result.errors.to_h}")
            end

            def initial_verification_request_entity(payload)
              Success(AcaEntities::Fdsh::Vlp::H92::InitialVerificationRequest.new(payload.to_h))
            end

            def construct_initial_request(payload)
              request = { InitialVerificationRequestSets: [construct_initial_verification_request_set(payload)] }

              Success(request)
            end

            def construct_initial_verification_request_set(person)
              {
                DHSID: construct_dhs_id_params(person),
                FirstName: person.person_name.first_name&.gsub(/[^A-Za-z]/, ''),
                MiddleName: person.person_name.middle_name&.gsub(/[^A-Za-z]/, ''),
                LastName: person.person_name.last_name&.gsub(/[^A-Za-z]/, ''),
                DateOfBirth: person.person_demographics.dob,
                AKA: person.person_name.alternate_name,
                FiveYearBarApplicabilityIndicator: true,
                RequestSponsorDataIndicator: false,
                RequestGrantDateIndicator: true,
                SuspectedCounterfeitAlteredDocumentIndicator: false,
                RequestCubanHaitianEntrantIndicator: false,
                DocumentBinaryAttachment: nil,
                RequesterCommentsForHub: nil,
                CasePOCFullName: 'DHS Tester',
                CasePOCPhoneNumber: '5555555555',
                CasePOCPhoneNumberExtension: '444'
              }
            end

            def construct_dhs_id_params(person)
              vlp_doc = person.consumer_role.vlp_documents.last
              subject = parse_dhs_id(vlp_doc.subject)
              { subject => all_dhs_id_sub_params(vlp_doc) }.symbolize_keys
            end

            def passport_country_doc(vlp_doc)
              return nil unless vlp_doc.passport_number
              {
                PassportNumber: vlp_doc.passport_number,
                CountryOfIssuance: vlp_doc.three_letter_country_of_citizenship
              }
            end

            def all_dhs_id_sub_params(vlp_doc)
              {
                AlienNumber: vlp_doc.alien_number,
                ReceiptNumber: vlp_doc.receipt_number,
                I94Number: vlp_doc.i94_number,
                VisaNumber: vlp_doc.visa_number,
                PassportNumber: vlp_doc.passport_number,
                CountryOfIssuance: vlp_doc.three_letter_country_of_citizenship,
                SEVISID: vlp_doc.sevis_id,
                DocExpirationDate: vlp_doc.expiration_date.to_date,
                CitizenshipNumber: vlp_doc.citizenship_number,
                NaturalizationNumber: vlp_doc.naturalization_number,
                PassportCountry: passport_country_doc(vlp_doc),
                DocDescReq: vlp_doc.subject[0..32]
              }
            end

            def parse_dhs_id(subject)
              {
                'I-327 (Reentry Permit)' => 'I327DocumentID',
                'I-551 (Permanent Resident Card)' => 'I551DocumentID',
                'I-571 (Refugee Travel Document)' => 'I571DocumentID',
                'I-766 (Employment Authorization Card)' => 'I766DocumentID',
                'Certificate of Citizenship' => 'CertOfCitDocumentID',
                'Naturalization Certificate' => 'NatrOfCertDocumentID',
                'Machine Readable Immigrant Visa (with Temporary I-551 Language)' => 'MacReadI551DocumentID',
                'Temporary I-551 Stamp (on passport or I-94)' => 'TempI551DocumentID',
                'I-94 (Arrival/Departure Record)' => 'I94DocumentID',
                'I-94 (Arrival/Departure Record) in Unexpired Foreign Passport' => 'I94UnexpForeignPassportDocumentID',
                'Unexpired Foreign Passport' => 'UnexpForeignPassportDocumentID',
                'I-20 (Certificate of Eligibility for Nonimmigrant (F-1) Student Status)' => 'I20DocumentID',
                'DS2019 (Certificate of Eligibility for Exchange Visitor (J-1) Status)' => 'DS2019DocumentID',
                'Other (With Alien Number)' => 'OtherCase1DocumentID',
                'Other (With I-94 Number)' => 'OtherCase2DocumentID'
              }.stringify_keys[subject.to_s]
            end
          end
        end
      end
    end
  end
end