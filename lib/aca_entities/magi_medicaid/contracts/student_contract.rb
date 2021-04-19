# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Contracts
      # Schema and validation rules for {AcaEntities::MagiMedicaid::Student}
      class StudentContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [Boolean] :is_student optional
        # @option opts [String] :student_kind optional
        # @option opts [String] :student_school_kind optional
        # @option opts [Date] :student_status_end_on optional
        # @return [Dry::Monads::Result]
        params do
          optional(:is_student).maybe(:bool)
          optional(:student_kind).maybe(Types::StudentKind)
          optional(:student_school_kind).maybe(Types::StudentSchoolKind)
          optional(:student_status_end_on).maybe(:date)
        end
      end
    end
  end
end