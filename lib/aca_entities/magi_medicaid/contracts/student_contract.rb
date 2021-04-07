# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Student}
      class StudentContract < Dry::Validation::Contract
        include ::AcaEntities::AppHelper
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Integer] :age_of_applicant required
        # @option opts [Boolean] :is_student optional
        # @option opts [String] :student_kind optional
        # @option opts [String] :student_school_kind optional
        # @option opts [Date] :student_status_end_on optional
        # @return [Dry::Monads::Result]
        params do
          required(:age_of_applicant).filled(:integer)
          optional(:is_student).maybe(:bool)
          optional(:student_kind).maybe(Types::StudentKind)
          optional(:student_school_kind).maybe(Types::StudentSchoolKind)
          optional(:student_status_end_on).maybe(:date)
        end

        rule(:is_student) do
          if Types::StudentRange.cover?(values[:age_of_applicant]) && check_if_blank?(value)
            key.failure(text: "must be filled if age of applicant is within #{Types::StudentRange}.")
          end
        end

        rule(:student_kind) do
          if Types::StudentRange.cover?(values[:age_of_applicant]) && check_if_blank?(value) && values[:is_student]
            key.failure(text: "must be filled if age of applicant is within #{Types::StudentRange}.")
          end
        end

        rule(:student_school_kind) do
          if Types::StudentRange.cover?(values[:age_of_applicant]) && check_if_blank?(value) && values[:is_student]
            key.failure(text: "must be filled if age of applicant is within #{Types::StudentRange}.")
          end
        end
      end
    end
  end
end