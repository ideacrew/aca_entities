# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SsfPrimaryContact
      class SsfPrimaryContact < Dry::Struct

        attribute :role_reference, RoleOfPersonReference.meta(omittable: false)
        attribute :contact_preference, Types::String.meta(omittable: false)
      end
    end
  end
end
