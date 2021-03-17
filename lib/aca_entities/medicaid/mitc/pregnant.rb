# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Mitc
      class Pregnant < Dry::Struct

        # does this belong here?
        field :is_enrolled_on_medicaid, type: Boolean

        field :is_pregnant, type: Boolean
        field :is_post_partum_period, type: Boolean
        field :children_expected_count, type: Integer, default: 0
        field :pregnancy_due_on, type: Date
        field :pregnancy_end_on, type: Date

      end
    end
  end
end