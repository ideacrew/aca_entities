# frozen_string_literal: true

module AcaEntities
  module Determinations
    class EligibilityDeterminationReference < Dry::Struct
      attribute :hbx_assigned_id,        Types::String.meta(omittable: false)
      attribute :effective_starting_on,  Types::Date.meta(omittable: false)
    end
  end
end