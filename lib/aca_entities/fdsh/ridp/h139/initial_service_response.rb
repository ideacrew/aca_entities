# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for InitialServiceResponse
        class InitialServiceResponse < Dry::Struct
          attribute :response_code,                       Types::String.meta(omittable: false)
          attribute :response_description_text,           Types::String.meta(omittable: false)
          attribute :session_identification,              Types::String.optional.meta(omittable: true)
          attribute :dsh_reference_number,                Types::String.optional.meta(omittable: true)
          attribute :final_decision_code,                 Types::String.optional.meta(omittable: true) # TODO: enum
          attribute :verification_question_text,          Types::Array.of(Types::String).meta(omittable: false)
          attribute :verification_answer_choice_text,     Types::Array.of(Types::String).meta(omittable: false)
        end
      end
    end
  end
end