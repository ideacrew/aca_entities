# frozen_string_literal: true

module AcaEntities
  module Households
    class TaxHouseholdSize < Dry::Struct

      attribute :adult_count,      Types::Integer.optional.meta(omittable: true)
      attribute :child_count,      Types::Integer.optional.meta(omittable: true)
      attribute :total_count,      Types::Integer.optional.meta(omittable: true)
    end
  end
end