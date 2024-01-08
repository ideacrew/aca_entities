# frozen_string_literal: true

require 'json'
require "json-schema"

module AcaEntities
  module Fdsh
    module Ridp
      module Rj139
        module Operations
          # convert evidence entity to ridp secondary request
          class EvidenceToSecondaryRequest
            include Dry::Monads[:result, :do, :try]

            def call(params)
              payload = yield construct_initial_request(params)
              validate_payload(payload)
            end

            private

            def construct_initial_request(payload)
              request = { ridpRequest: { secondaryRequest: construct_primary_request(payload) } }
              Success(request)
            end

            def construct_primary_request(payload)
              {
                verificationAnswerArray: construct_answer_array(payload[:VerificationAnswerSet]),
                sessionIdentification: payload[:SessionIdentification],
                hubReferenceNumber: payload[:transmission_id]
              }
            end

            def construct_answer_array(answers)
              answers[:VerificationAnswers].collect do |answer|
                { verificationAnswerSet: { verificationAnswer: answer[:VerificatonAnswer]&.to_s,
                                           verificationQuestionNumber: answer[:VerificationQuestionNumber]&.to_s } }
              end
            end

            def validate_payload(payload)
              schema_data = JSON.parse(File.read(Pathname.pwd.join("lib/aca_entities/fdsh/ridp/rj139/schemas/RIDP-Request-schema.json")))

              # CMS requested no blank data be sent in the request
              payload[:ridpRequest][:secondaryRequest].delete_if { |_k, v| v.blank? }

              result = begin
                JSON::Validator.fully_validate(schema_data, JSON.parse(payload.to_json))
              rescue JSON::Schema::ValidationError => e
                e.message
              end
              result.empty? ? Success(payload.to_json) : Failure(result.to_s)
            end
          end
        end
      end
    end
  end
end