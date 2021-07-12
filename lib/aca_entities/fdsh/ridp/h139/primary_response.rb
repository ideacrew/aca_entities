# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for PrimaryResponse
        class PrimaryResponse < Dry::Struct

          attribute :Response do
            attribute :ResponseMetadata do
              attribute :ResponseCode,                      Types::String.meta(omittable: false)
              attribute :ResponseDescriptionText,           Types::String.meta(omittable: false)
              attribute :TDSResponseDescriptionText,        Types::String.optional.meta(omittable: true)
            end

            attribute :VerificationResponse do
              attribute :SessionIdentification,             Types::String.optional.meta(omittable: true)
              attribute :DSHReferenceNumber,                Types::String.optional.meta(omittable: true)
              attribute :FinalDecisionCode,                 Types::String.optional.meta(omittable: true) # TODO: enum

              attribute? :VerificationQuestions do
                attribute :VerificationQuestionSet, Types::Array do
                  attribute :VerificationQuestionText,        Types::String.optional.meta(omittable: true)
                  attribute :VerificationAnswerChoiceText,    Types::Array.optional.meta(omittable: true)
                end
              end
            end
          end
        end
      end
    end
  end
end
