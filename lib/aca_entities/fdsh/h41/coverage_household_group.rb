# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for h41 CoverageHouseholdGroup
      class CoverageHouseholdGroup < Dry::Struct
        attribute :CoveredIndividuals,  Types::Array.of(AcaEntities::Fdsh::H41::CoveredIndividual).meta(omittable: false)
      end
    end
  end
end
