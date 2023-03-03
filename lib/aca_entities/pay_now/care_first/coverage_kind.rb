# frozen_string_literal: true

module AcaEntities
    module PayNow
      module CareFirst
        # entity for coverage_kind
        class CoverageKind < Dry::Struct

          attribute :coverage_kind, Types::String.optional.meta(omittable: true)

        end
      end
    end
  end