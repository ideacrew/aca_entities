# frozen_string_literal: true

module AcaEntities
  # Entity for BasisForOutcome.
  class BasisForOutcome < Dry::Struct

    attribute :is_blind_or_disabled,  Types::Bool.optional.meta(omittable: true)
    attribute :attested_long_term_care,  Types::Bool.optional.meta(omittable: true)
  end
end
