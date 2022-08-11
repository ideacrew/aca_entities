# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

require 'aca_entities/medicaid/mec_check'

module AcaEntities
  module Medicaid
    module MecCheck
      module Operations
        # MecCheck operation to generate eligibility result from response payload
        class GenerateResult
          include Dry::Monads[:result, :do, :try]

          def call(body)
            serialized_response = yield serialize(body)
            transform_response(serialized_response)
          end

          def serialize(body)
            result = if Nokogiri.parse(body).xpath("//xmlns:ResponseDescription", "xmlns" => "http://gov.hhs.cms.hix.dsh.ee.nonesi_mec.ext").present?
                       ::AcaEntities::Serializers::Xml::Medicaid::MecCheck::VerifyNonEsiMecResponse.parse(body)
                     else
                       AcaEntities::Serializers::Xml::Medicaid::MecCheck::GetEligibilityIndividualInformationResponse.parse(body)
                     end
            Success(result)
          rescue StandardError => e
            Failure("MEC response serializer error: #{e}")
          end

          def transform_response(response)
            if response.to_hash[:non_esi_mec_response]
              response_hash = response.to_hash[:non_esi_mec_response]
              {
                result: :eligible,
                source: response_hash.dig(:non_esi_mec_individual_response, :organization_code),
                code: response_hash[:response_code],
                code_description: response_hash[:response_description],
                mec_verification_code: response_hash.dig(:non_esi_mec_individual_response, :source_information, :mec_verification_code)
              }
            else
              {
                code_description: response.to_hash[:eligibility_flag],
                mec_verification_code: response.to_hash[:resp_code]
              }
            end
          end
        end
      end
    end
  end
end