# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    # An class or object to which an elifiblity is applied
    class Subject < Dry::Struct
      attribute :gid, Types::String.meta(omittable: true)
      attribute :determinations, Types::Array.of(AcaEntities::Eligibilities::Determination).meta(omittable: true)
    end
  end
end
