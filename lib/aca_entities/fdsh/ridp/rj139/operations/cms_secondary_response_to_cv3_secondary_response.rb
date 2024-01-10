# frozen_string_literal: true

require 'json'
require "json-schema"

module AcaEntities
  module Fdsh
    module Ridp
      module Rj139
        module Operations
          # convert cms ridp secondary response payload into a cv3 secondary request
          class CmsSecondaryResponseToCv3SecondaryResponse
            include Dry::Monads[:result, :do, :try]

            def call(params)
              payload = yield validate_payload(params)
              response = yield construct_secondary_response(payload)
              validate_secondary_response(response)
            end

            private

            def validate_payload(payload)
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/ridp/rj139/schemas/RIDP-Response-schema.json")))

              result = begin
                JSON::Validator.fully_validate(schema_data, JSON.parse(payload.to_json))
              rescue JSON::Schema::ValidationError => e
                e.message
              end
              result.empty? ? Success(payload) : Failure(result.to_s)
            end

            def construct_secondary_response(payload)
              parsed_paylod = JSON.parse(payload.to_json)
              ridp = parsed_paylod["ridpResponse"]
              result_hash = {
                Response: {
                  ResponseMetadata: {
                    ResponseCode: ridp["responseMetadata"]["responseCode"],
                    ResponseDescriptionText: ridp["responseMetadata"]["responseText"],
                    TDSResponseDescriptionText: ridp["responseMetadata"]["tdsResponseText"]
                  },
                  VerificationResponse: {
                    SessionIdentification: ridp["sessionIdentification"],
                    DSHReferenceNumber: ridp["hubReferenceNumber"],
                    FinalDecisionCode: ridp["finalDecisionCode"]
                  }
                }
              }
              Success(result_hash)
            end

            def validate_secondary_response(payload)
              result = ::AcaEntities::Fdsh::Ridp::H139::SecondaryResponseContract.new.call(payload)

              if result.success?
                Success(payload)
              else
                Failure("Invalid response, #{result.errors.to_h}")
              end
            end

          end
        end
      end
    end
  end
end