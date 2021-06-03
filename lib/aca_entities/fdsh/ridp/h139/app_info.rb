# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ridp
      module H139
        # Entity for FarsRequest
        class AppInfo < Dry::Struct

          attribute :applies_to do
            attribute :name,        Types::String.meta(omittable: false)
            attribute :namespace,   Types::String.optional.meta(omittable: true)
          end

          attribute :base do
            attribute :name,        Types::String.meta(omittable: false)
            attribute :namespace,   Types::String.optional.meta(omittable: true)
          end

          attribute :deprecated do
            attribute :value, Types::Bool.meta(omittable: false)
          end

          attribute :reference_target do
            attribute :name,        Types::String.meta(omittable: false)
            attribute :namespace,   Types::String.optional.meta(omittable: true)
          end

          attribute :resource do
            attribute :name,   Types::String.meta(omittable: false)
          end

          attribute :conformant_indicator,            Types::Bool.optional.meta(omittable: true)
          attribute :external_adapter_type_indicator, Types::Bool.optional.meta(omittable: true)
          attribute :augmented_type_indicator,        Types::Bool.optional.meta(omittable: true)
          attribute :augmented_element_indicator,     Types::Bool.optional.meta(omittable: true)

        end
      end
    end
  end
end