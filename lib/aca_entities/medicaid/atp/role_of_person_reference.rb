# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp RoleOfPersonReference
      class RoleOfPersonReference < Dry::Struct

        attribute :ref, Types::String.meta(omittable: false)
      end
    end
  end
end
