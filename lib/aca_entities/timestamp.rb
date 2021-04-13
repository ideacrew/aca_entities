# frozen_string_literal: true

module Entities
  class TimeStamp < Dry::Struct

    attribute :submitted_at,                        Types::Date.optional.meta(omittable: true)
    attribute :created_at,                          Types::Date.optional.meta(omittable: true)
    attribute :modified_at,                         Types::Date.optional.meta(omittable: true)
  end
end