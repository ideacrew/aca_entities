# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp PrimaryTaxFiler
      class PrimaryTaxFiler < Dry::Struct

        attribute :role_reference, RoleOfPersonReference.meta(omittable: false)
      end
    end
  end
end