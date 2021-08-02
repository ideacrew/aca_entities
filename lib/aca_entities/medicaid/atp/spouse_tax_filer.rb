# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SpouseTaxFiler
      class SpouseTaxFiler < Dry::Struct

        attribute :role_reference, RoleOfPersonReference.meta(omittable: false)
      end
    end
  end
end