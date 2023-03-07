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
            #   namespace 'gov'

              element :coverage_kind, String, tag: 'coverage_kind'
  
              def self.domain_to_mapper(coverage_kind)
                mapper = self.new
                mapper.coverage_kind = coverage_kind
                mapper
              end

            #   def to_hash
            #     {
            #       non_esi_mec_individual_information: transfer_header.to_hash
            #     }
            #   end
            end
          end
        end
      end
    end
  end