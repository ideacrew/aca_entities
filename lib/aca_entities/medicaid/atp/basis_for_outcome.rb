# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for atp BasisForOutcome.
      class BasisForOutcome < Dry::Struct

        attribute :is_blind_or_disabled,  Types::Bool.optional.meta(omittable: true)
        attribute :attested_long_term_care,  Types::Bool.optional.meta(omittable: true)
      end
    end
  end
end
