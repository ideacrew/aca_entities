# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # An class or object to which an eligiblity is applied
    class Subject < Dry::Struct
      attribute :gid, Types::Coercible::String.meta(omittable: false)
      attribute :first_name, Types::String.meta(omittable: false)
      attribute :last_name, Types::String.meta(omittable: false)
      attribute :is_primary, Types::Bool.meta(omittable: false)
      attribute :determinations, Types::Hash.meta(omittable: false)
    end
  end
end
