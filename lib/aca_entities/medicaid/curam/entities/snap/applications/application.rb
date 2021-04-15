# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Snap
        module Applications
          # snap #application
          class Application < Programs::Application
            attribute :eligibility_determinations, Types::Array.of(Snap::EligibilityDeterminations::EligibilityDetermination).meta(omittable: false)
          end
        end
      end
    end
  end
end
