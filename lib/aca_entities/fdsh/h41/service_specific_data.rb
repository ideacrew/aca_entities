# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module H41
      # Entity for H41 ServiceSpecificData
      class ServiceSpecificData < Dry::Struct
        attribute :ReportPeriod, Dry::Struct.optional.meta(omittable: true) do
          attribute :Year,  AcaEntities::Types::Integer.optional.meta(omittable: true)
        end
        attribute :OriginalBatchId,  AcaEntities::Types::String.optional.meta(omittable: true)
      end
    end
  end
end
