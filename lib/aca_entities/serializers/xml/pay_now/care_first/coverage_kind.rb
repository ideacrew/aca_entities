# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module PayNow
        module CareFirst
          # Happymapper implementation for coverage_kind
          class CoverageKind
            include HappyMapper

            tag 'coverage_kind'

            element :coverage_kind, String, tag: 'coverage_kind'

            def self.domain_to_mapper(coverage_kind)
              mapper = self.new
              mapper.coverage_kind = coverage_kind
              mapper
            end
          end
        end
      end
    end
  end
end