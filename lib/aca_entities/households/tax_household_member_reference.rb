# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdMemberReference < Dry::Struct
      attribute :is_subscriber,                                   Types::Bool.meta(omittable: false)
      attribute :reason,                                          Types::String.optional.meta(omittable: true)
    end
  end
end
