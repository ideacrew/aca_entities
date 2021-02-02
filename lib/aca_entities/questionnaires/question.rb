# frozen_string_literal: true

module AcaEntities
  module Shared
    module Questionnaire

      # A Question is an individual query and its corresponding response value
      class Question < Dry::Struct

        # @!attribute [r] key
        # An unambiguous reference to the resource
        # @return [String]
        attribute :key,                 Types::String.meta(omittable: false)

        # @!attribute [r] label
        # The human-readable label assigned to this resource
        # @return [String]
        attribute :label,               Types::String.optional.meta(ommitable: true)

        # @!attribute [r] description
        # An optional account of the content of this resource
        # @return [String]
        attribute :description,         Types::String.optional.meta(ommitable: true)

        # @!attribute [r] kind
        # The data type expected in the response.  Default is 'string'
        # @return [DataTypeKind]
        attribute :kind, Cartafact::Types::DataTypeKind.meta(omittable: false)

        # @!attribute [r] default_value
        # An optional value to assign to the {response} attribute if another value isn't provided
        # @return [Any]
        attribute :default_value,       Type::Any.optional.meta(ommitable: true)

        # @!attribute [r] response
        # An answer value to this Question
        # @return [Boolean]
        attribute :response,            Types::Any.optional.meta(ommitable: true)

        # @!attribute [r] dependent_questions
        # A list of questions that are enabled/disabled based on the presence of a response
        # to this question.  For example, if this question's response value is nil, is_enabled => false
        # for all questions referenced in this set
        # @return [Boolean]
        attribute :dependent_questions, Types::Array.of(DependentQuestion).optional.meta(ommitable: true)

        # @!attribute [r] is_required
        # Flag indicating that a response value is required for this question
        # instance
        # @return [Boolean]
        attribure :is_required,          Types::Bool.meta(ommitable: false)

        # @!attribute [r] is_enabled
        # Flag indicating whether the question is active in this Questionnaire
        # instance
        # @return [Boolean]
        attribure :is_enabled,          Types::Bool.meta(ommitable: false)

        # @!attribute [r] is_visible
        # Flag indicating whether the question should display in the UI
        # @return [Boolean]
        attribure :is_visible,          Types::Bool.meta(ommitable: false)

        # @!attribute [r] order
        # The sequence in which this question appears relative to other questions
        # under the same Topic.  Questions will display in ascending order
        # based on the order value.  For example, a Question with order => 10 will
        # appear before a Question with order => 20.
        # @return [Integer]
        attribute :order,               Types::Integer.optional.meta(ommitable: true)

      end
    end
  end
end
