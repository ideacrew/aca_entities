# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

module AcaEntities
  module Fdsh
    module Operations
      module Ridp
        # This class takes happy mapper hash as input and returns
        class ProcessPrimaryResponse
          include Dry::Monads[:result, :do, :try]
          include AcaEntities::AppHelper

          # @param [Hash] opts The options to process
          # @return [Dry::Monads::Result]
          def call(xml_response)
            parsed_xml         = yield process_xml(xml_response)
            params             = yield construct_params(parsed_xml)
            valid_response     = yield validate_primary_response(params)
            primary_response   = yield create_primary_response(valid_response)
            ridp_attestation   = yield create_ridp_attestation(primary_response)
            attestation        = yield create_attestation(ridp_attestation)

            Success(attestation)
          end

          private

          def process_xml(xml_response)
            result = AcaEntities::Serializers::Xml::Fdsh::Ridp::PrimaryResponse.parse(xml_response.root.canonicalize, :single => true)
            Success(result)
          end

          def construct_params(parsed_xml)
            questions_set = parsed_xml.verification_response.verification_questions.verification_question_sets.collect do |question_set|
              {
                VerificationQuestionText: question_set.VerificationQuestionText,
                VerificationAnswerChoiceText: question_set.VerificationAnswerChoiceText
              }
            end
            result_hash = {
              Response: {
                ResponseMetadata: {
                  ResponseCode: parsed_xml.response_metadata.ResponseCode,
                  ResponseDescriptionText: parsed_xml.response_metadata.ResponseDescriptionText,
                  TDSResponseDescriptionText: parsed_xml.response_metadata.TDSResponseDescriptionText
                },

                VerificationResponse: {
                  SessionIdentification: parsed_xml.verification_response.SessionIdentification,
                  DSHReferenceNumber: parsed_xml.verification_response.DSHReferenceNumber,
                  FinalDecisionCode: parsed_xml.verification_response.FinalDecisionCode,
                  VerificationQuestions: { VerificationQuestionSet: questions_set }
                }
              }
            }

            Success(result_hash)
          end

          # Validate input object
          def validate_primary_response(payload)
            result = ::AcaEntities::Fdsh::Ridp::H139::PrimaryResponseContract.new.call(payload)

            if result.success?
              Success(result)
            else
              Failure("Invalid response, #{result.errors}")
            end
          end

          def create_primary_response(value)
            Success(::AcaEntities::Fdsh::Ridp::H139::PrimaryResponse.new(value.to_h))
          end

          def create_ridp_attestation(primary_response)
            ::AcaEntities::Fdsh::Operations::Ridp::CreateRidpAttestation.call(primary_response)
          end

          def create_attestation(_ridp_attestation)
            Success(::AcaEntities::Attestations::Attestation.new({ ridp_attestation: 'ridp_attestation' }))
          end
        end
      end
    end
  end
end
