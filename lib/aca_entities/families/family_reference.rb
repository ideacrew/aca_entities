# frozen_string_literal: true

module AcaEntities
  module Families
    class FamilyReference < Dry::Struct

      # This maps to hbx_assigned_id of family.
      attribute :hbx_id,          Types::String.optional.meta(omittable: false)
    end
  end
end