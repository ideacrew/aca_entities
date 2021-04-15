# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module MagiMedicaidEligibilityDeterminations
        # MagiMedicaidEligibilityDetermination Recorded Result
        class MagiMedicaidEligibilityDeterminationRecordedResult < Dry::Struct
          attribute :aggregate_id, Types::String.meta(omittable: false)
          attribute :checksum, Types::String.meta(omittable: false)
        end
      end
    end
  end
end