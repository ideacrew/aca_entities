module Ehs
  module MagiMedicaidEligibilityDeterminations
    class MagiMedicaidEligibilityDeterminationRecordedResult < Dry::Struct
      attribute :aggregate_id, Types::String.meta(omittable: false)
      attribute :checksum, Types::String.meta(omittable: false)
    end
  end
end