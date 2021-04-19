# frozen_string_literal: true

module AcaEntities
  class AllocatedAptc < Dry::Struct

    attribute :calendar_year,     Types::Integer.optional.meta(omittable: true)
    attribute :total_amount,      Types::Decimal.optional.meta(omittable: true)
  end
end