# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Snap
        module EligibilityDeterminations
          # snap EligibilityDetermination
          class EligibilityDetermination < Programs::EligibilityDetermination

            attribute :source_system_identifier, Identifiers::Id.meta(omittable: false)
          end
        end
      end
    end
  end
end
