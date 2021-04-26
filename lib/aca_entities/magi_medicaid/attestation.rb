# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Cv3 IAP Entity for Attestation.
    class Attestation < Dry::Struct
      attribute :is_incarcerated, Types::Bool.optional.meta(omittable: true)
      attribute :is_self_attested_disabled, Types::Bool.optional.meta(omittable: true)
      attribute :is_self_attested_blind, Types::Bool.optional.meta(omittable: true)
      attribute :is_self_attested_long_term_care, Types::Bool.optional.meta(omittable: true)
    end
  end
end
