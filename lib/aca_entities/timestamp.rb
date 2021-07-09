# frozen_string_literal: true

module AcaEntities
  class TimeStamp < Dry::Struct

    attribute :submitted_at,                        Types::DateTime.optional.meta(omittable: true)
    attribute :created_at,                          Types::DateTime.optional.meta(omittable: true)
    attribute :modified_at,                         Types::DateTime.optional.meta(omittable: true)
  end
end