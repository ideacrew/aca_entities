# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class CoverageHouseholdGroup
            include HappyMapper
            register_namespace 'airty22a', 'urn:us:gov:treasury:irs:ext:aca:air:ty22a'

            tag 'CoverageHouseholdGrp'
            namespace 'airty22a'

            has_many :CoveredIndividuals, CoveredIndividual

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.CoveredIndividuals = request.CoveredIndividuals.collect do |request_group|
                CoveredIndividual.domain_to_mapper(request_group)
              end

              mapper
            end
          end
        end
      end
    end
  end
end
