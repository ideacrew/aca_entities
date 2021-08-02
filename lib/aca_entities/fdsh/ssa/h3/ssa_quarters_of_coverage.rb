# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSAQuartersOfCoverage < Dry::Struct
          attribute :LifeTimeQuarterQuantity, Types::Integer.meta(omittable: false)
          attribute :QualifyingYearAndQuarter, AcaEntities::Fdsh::Ssa::H3::QualifyingYearAndQuarter.meta(omittable: false)
        end
      end
    end
  end
end