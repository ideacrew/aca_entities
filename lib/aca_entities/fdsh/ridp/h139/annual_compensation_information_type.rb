# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for AnnualCompensationInformationType
        class AnnualCompensationInformationType < Dry::Struct

          attribute :income_year,          Types::Date.optional.meta(omittable: true)
          attribute :base_compensation,    Types::Float.optional.meta(omittable: true)
          attribute :total_compensation,   Types::Float.optional.meta(omittable: true)
        end
      end
    end
  end
end