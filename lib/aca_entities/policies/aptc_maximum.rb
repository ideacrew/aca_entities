# frozen_string_literal: true

module AcaEntities
  module Policies
    # entity for AptcMaximum
    class AptcMaximum < Dry::Struct
      attribute :start_on,      Types::Date.optional.meta(omittable: true)
      attribute :end_on,        Types::Date.optional.meta(omittable: true)
      attribute :max_aptc,      Types::Float.optional.meta(omittable: true)
      attribute :aptc_percent,  Types::Float.optional.meta(omittable: true)
    end
  end
end
