# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp NotIncarceratedIndicator
      class NotIncarceratedIndicator < Dry::Struct
        attribute :value,     Types::Bool.meta(omittable: false)
        attribute :metadata,  Types::String.optional.meta(omittable: true)
      end
    end
  end
end