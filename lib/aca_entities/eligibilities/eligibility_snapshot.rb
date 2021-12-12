# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    #
    class EligibilitySanpshot < Dry::Struct
      attribute :eligibility_items, Types::Array.of(AcaEntities::Eligibilities::EligibilityItem).default([]).meta(ommittable: false)
      attribute :subjects, Types::Hash.meta(ommittable: true)
    end
  end
end
