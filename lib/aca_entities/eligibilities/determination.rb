# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    class Determination < Dry::Struct
      attribute :eligibility_key, Types::String.meta(ommittable: false)

      attribute :subject, Types::String.meta(ommittable: false)

      attribute :status,
                AcaEntities::Eligibilities::Types::DeterminationStatusKind.meta(
                  ommittable: false
                )

      attribute :evidence_states,
                Types::Array
                  .of(AcaEntities::Eligibilities::EvidenceState)
                  .defulate([])
                  .meta(ommittable: false)

      attribute :determined_at, Types::DateTime.meta(ommittable: false)
    end
  end
end

# frozen_string_literal: true

module AcaEntities
  # All types Eligibilities
  module Eligibilities
    class Determination
    end
  end
end
