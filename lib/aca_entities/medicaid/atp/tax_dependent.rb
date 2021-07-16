# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp TaxDependent
      class TaxDependent < Dry::Struct

        attribute :role_reference, RoleOfPersonReference.meta(omittable: false)
        attribute :claimed_by_custodial_parent_indicator, Types::Bool.optional.meta(omittable: true)
        attribute :tin_identification, TinIdentification.optional.meta(omittable: true)
      end
    end
  end
end