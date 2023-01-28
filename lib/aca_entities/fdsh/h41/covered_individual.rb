# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 CoveredIndividual
      class CoveredIndividual < Dry::Struct
        attribute :InsuredPerson,  AcaEntities::Fdsh::H41::InsuredPerson.meta(omittable: false)
        attribute :CoverageStartDt,  AcaEntities::Types::Date.meta(omittable: false)
        attribute :CoverageEndDt,  AcaEntities::Types::Date.optional.meta(omittable: true)
      end
    end
  end
end
