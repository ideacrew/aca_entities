# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for Student
    class Student < Dry::Struct
      attribute :is_student, Types::Bool.optional.meta(omittable: true)
      attribute :student_kind, Types::String.optional.meta(omittable: true)
      attribute :student_school_kind, Types::String.optional.meta(omittable: true)
      attribute :student_status_end_on, Types::Date.optional.meta(omittable: true)
    end
  end
end
