# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for EmploymentInfoType
        class EmploymentInfoType < Dry::Struct

          attribute :employee_status_code,              Types::String.meta(omittable: false)
          attribute :employee_status_message,           Types::String.meta(omittable: false)
          attribute :person_employment_association,     Fdsh::Ridp::H139::PersonEmploymentAssociationType.optional.meta(omittable: true)

        end
      end
    end
  end
end