# frozen_string_literal: true

module AcaEntities
  module Families
    class FamilyReference < Dry::Struct

      # This maps to hbx_assigned_id of family.
      attribute :hbx_id,          Types::String.meta(omittable: true)
    end
  end
end