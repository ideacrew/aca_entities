# frozen_string_literal: true

module AcaEntities
  # Attributes for managin dates and times when records were created, updated
  #   and submitted
  class TimeStamp < Dry::Struct
    include Comparable

    attribute :submitted_at, Types::DateTime.optional.meta(omittable: true)
    attribute :created_at, Types::DateTime.optional.meta(omittable: true)
    attribute :modified_at, Types::DateTime.optional.meta(omittable: true)

    def <=>(other)
      [submitted_at.to_i, modified_at.to_i, created_at.to_i] <=> [
        other.submitted_at.to_i,
        other.modified_at.to_i,
        other.created_at.to_i
      ]
    end
  end
end
