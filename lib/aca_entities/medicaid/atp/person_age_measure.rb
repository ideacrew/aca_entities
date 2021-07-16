# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PersonAgeMeasure
      class PersonAgeMeasure < Dry::Struct

        attribute :measure_point_value, Types::Integer.optional.meta(omittable: true)
      end
    end
  end
end
