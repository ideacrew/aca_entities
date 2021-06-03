# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for PersonEmploymentAssociationType
        class PersonEmploymentAssociationType < Dry::Struct

          attribute :employment_original_hire_date,   Types::Date.optional.meta(omittable: true)

        end
      end
    end
  end
end