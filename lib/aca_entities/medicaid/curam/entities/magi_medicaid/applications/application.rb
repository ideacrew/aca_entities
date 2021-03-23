# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaid
        module Applications
          # entity for Magi Medicaid application
          class Application < Programs::Application
            attribute :source_system_identifier,          Identifiers::Id.meta(omittable: false)
            attribute :years_to_renew_coverage,           Types::Integer.optional.meta(omittable: true)
            attribute :is_employer_sponsored_application, Types::Bool.optional.meta(omittable: true)
            attribute :coverage_year,                     Types::Integer.optional.meta(omittable: true)
            attribute :eligibility_determinations,
                      Types::Array.of(MagiMedicaid::EligibilityDeterminations::EligibilityDetermination).meta(omittable: false)
          end
        end
      end
    end
  end
end
