# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module NonEsi
      module H31
        # Entity for Fdsh NON ESI(employer sponsored insurance) MECCoverage
        class InsuranceDate < Dry::Struct
          attribute :Date, Types::Date.meta(omittable: false)
        end
      end
    end
  end
end