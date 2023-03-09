# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H36
      # Entity for H36 ServiceSpecificData
      class ServiceSpecificData < Dry::Struct
        attribute :ReportPeriod, Dry::Struct.optional.meta(omittable: true) do
          attribute :YearMonth,  AcaEntities::Types::String.optional.meta(omittable: true)
        end
      end
    end
  end
end