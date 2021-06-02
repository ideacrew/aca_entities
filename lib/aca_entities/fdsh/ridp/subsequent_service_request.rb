# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      # Entity for SubsequentServiceRequest
      class SubsequentServiceRequest < Dry::Struct
        attribute :session_identification,          Types::String.meta(omittable: false)
        attribute :verification_answer,             Types::Integer.meta(omittable: false)
        attribute :verification_question_number,    Types::Integer.meta(omittable: false)

      end
    end
  end
end