# frozen_string_literal: true

module Ehs
  class Programs::Application < Dry::Struct

    attribute :evidences,                  Types::Array.of(Evidences::Evidence).optional.meta(omittable: true)
    attribute :eligibility_determinations, Types::Array.of(Programs::EligibilityDetermination).meta(omittable: false)
    attribute :submitted_at,               Types::DateTime.meta(omittable: false)
  end
end
