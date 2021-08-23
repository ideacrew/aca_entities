# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ssa
      module H3
        # Entity for Fdsh SSAVerification Response
        class SSATitleIIYearlyIncome < Dry::Struct
          attribute :TitleIIRequestedYearInformation, AcaEntities::Fdsh::Ssa::H3::TitleIIRequestedYearInformation.optional.meta(omittable: true)
        end
      end
    end
  end
end