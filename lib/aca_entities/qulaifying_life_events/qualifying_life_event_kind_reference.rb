# frozen_string_literal: true

module AcaEntities
  module QualifyingLifeEvents
    class QualifyingLifeEventKindReference < Dry::Struct

      attribute :start_on,                        Types::Date.optional.meta(omittable: true)
      attribute :end_on,                          Types::Date.optional.meta(omittable: true)
      attribute :title,                           Types::String.optional.meta(omittable: true)
      attribute :reason,                          Types::String.optional.meta(omittable: true)
      attribute :market_kind,                     Types::String.optional.meta(omittable: true)
    end
  end
end