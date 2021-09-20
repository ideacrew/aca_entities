# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Medicare
        # Entity for Insurance
        class Insurance < Dry::Struct
          attribute :InsuranceEffectiveDate, Types::Date.optional.meta(omittable: true)
          attribute :InsuranceEndDate, Types::Date.optional.meta(omittable: true)
        end
      end
    end
  end
end