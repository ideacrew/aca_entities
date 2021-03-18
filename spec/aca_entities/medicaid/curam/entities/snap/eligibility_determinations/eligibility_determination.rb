# frozen_string_literal: true

module Ehs
  class Snap::EligibilityDeterminations::EligibilityDetermination < Programs::EligibilityDetermination

    attribute :source_system_identifier, Identifiers::Id.meta(omittable: false)
  end
end
