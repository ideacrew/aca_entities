# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SsfAttestation
      class SsfAttestation < Dry::Struct

        attribute :non_perjury_indicator, Types::Bool.meta(omittable: false)
        attribute :not_incarcerated_indicator, Types::Bool.meta(omittable: false)
        attribute :information_changes_indicator, Types::Bool.meta(omittable: false)
      end
    end
  end
end
