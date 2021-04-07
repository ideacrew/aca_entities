# frozen_string_literal: true

module AcaEntities
  module Families
    class FamilyMemberReference < Dry::Struct
      # TODO: Person hbx_id until we add hbx_id on family member
      attribute :hbx_id,          Types::String.meta(omittable: true)
    end
  end
end