# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Osse
      # An class or object to which an eligiblity is applied
      class Subject < Dry::Struct
        # attribute :gid, Types::Coercible::String.meta(omittable: false)

        attribute :title, Types::String.meta(omittable: false)
        attribute :description?, Types::String.meta(omittable: true)
        attribute :key, Types::Coercible::String.meta(omittable: false)
        attribute :klass, Types::String.meta(omittable: false)
      end
    end
  end
end
