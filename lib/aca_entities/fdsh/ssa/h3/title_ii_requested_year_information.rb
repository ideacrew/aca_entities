# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class TitleIIRequestedYearInformation < Dry::Struct
          attribute :IncomeDate, Types::String.meta(omittable: true)
          attribute :YearlyIncomeAmount, Types::Float.meta(omittable: true)
        end
      end
    end
  end
end