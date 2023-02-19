# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for H36 CoveredIndividual
      class CoveredIndividual < Dry::Struct
        attribute :InsuredPerson,  AcaEntities::Fdsh::H36::InsuredPerson.meta(omittable: false)
        attribute :CoverageStartDt,  AcaEntities::Types::Date.meta(omittable: false)
        attribute :CoverageEndDt,  AcaEntities::Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
