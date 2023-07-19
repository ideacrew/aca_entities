# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSAQuartersOfCoverageContract < Dry::Validation::Contract
          params do
            required(:LifeTimeQuarterQuantity).maybe(:integer)
            optional(:QualifyingYearAndQuarter).maybe(AcaEntities::Fdsh::Ssa::H3::QualifyingYearAndQuarterContract.params)
            optional(:QualifyingYearAndQuarterArray).array(AcaEntities::Fdsh::Ssa::H3::QualifyingYearAndQuarterContract.params)
          end

          rule(:QualifyingYearAndQuarter, :QualifyingYearAndQuarterArray) do
            unless key?(:QualifyingYearAndQuarter) || key?(:QualifyingYearAndQuarterArray)
              key.failure('qualifying year and quarter information is required')
            end
            if key?(:QualifyingYearAndQuarter) && !values[:QualifyingYearAndQuarter]
              key.failure('qualifying year and quarter information is required')
            end
            if key?(:QualifyingYearAndQuarterArray) && !values[:QualifyingYearAndQuarterArray]
              key.failure('qualifying year and quarter information is required')
            end
          end
        end
      end
    end
  end
end