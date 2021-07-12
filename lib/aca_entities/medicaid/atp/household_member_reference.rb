# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # Entity for HouseholdMemberReference
      class HouseholdMemberReference < Dry::Struct
        attribute :ref,       Types::String.optional.meta(omittable: false)
      end
    end
  end
end
