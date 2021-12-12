# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    class Determination < Dry::Struct
      attribute :key, Types::String.meta(ommittable: false)
      attribute :status, AcaEntities::Eligibilities::Types::DeterminationStateKind.meta(ommittable: false)

      attribute :earliest_due_date, Types::DateTime.meta(ommittable: false)
      attribute :determined_at, Types::DateTime.meta(ommittable: false)
    end
  end
end
