# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class QualifyingYearAndQuarter < Dry::Struct
          attribute :QualifyingYear, Types::String.meta(omittable: false)
          attribute :QualifyingQuarter, Types::Integer.meta(omittable: false)
        end
      end
    end
  end
end