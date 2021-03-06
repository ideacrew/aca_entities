# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for atp PregnancyInformation
      class PregnancyInformation < Dry::Struct
        attribute :is_pregnant, Types::Bool.optional.meta(omittable: true)
        attribute :expected_children_count, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end
