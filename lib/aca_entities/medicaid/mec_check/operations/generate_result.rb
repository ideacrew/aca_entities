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
            result = ::AcaEntities::Serializers::Xml::Medicaid::MecCheck::VerifyNonEsiMecResponse.parse(body)
            Success(result)
          rescue StandardError => e
            Failure("MEC response serializer error: #{e}")
          end

          def transform_response(response)
            response_hash = response.to_hash[:non_esi_mec_response]
            {
              result: :eligible,
              source: response_hash.dig(:non_esi_mec_individual_response, :organization_code),
              code: response_hash[:response_code],
              code_description: response_hash[:response_description],
              mec_verification_code: response_hash.dig(:non_esi_mec_individual_response, :source_information, :mec_verification_code)
            }
          end
        end
      end
    end
  end
end