# frozen_string_literal: true

module Ehs
  class Snap::Applications::Application < Programs::Application
    attribute :eligibility_determinations, Types::Array.of(Snap::EligibilityDeterminations::EligibilityDetermination).meta(omittable: false)
  end
end
