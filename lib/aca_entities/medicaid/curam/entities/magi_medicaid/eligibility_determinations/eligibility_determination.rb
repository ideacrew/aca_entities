# frozen_string_literal: true

module Ehs
  class MagiMedicaid::EligibilityDeterminations::EligibilityDetermination < Programs::EligibilityDetermination

    attribute :source_system_identifier, Identifiers::Id.meta(omittable: false)
  end
end
