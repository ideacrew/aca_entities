# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H36
          # Happymapper implementation for the root object of an CoveredIndividual.
          class CoveredIndividual
            include HappyMapper

            tag 'CoveredIndividual'

            has_one :InsuredPerson, InsuredPerson
            element :CoverageStartDt, String, tag: "CoverageStartDt"
            element :CoverageEndDt, String, tag: "CoverageEndDt"

            def self.domain_to_mapper(request)
              mapper = self.new
              mapper.InsuredPerson = InsuredPerson.domain_to_mapper(request.InsuredPerson)
              mapper.CoverageStartDt = request.CoverageStartDt
              mapper.CoverageEndDt = request.CoverageEndDt

              mapper
            end
          end
        end
      end
    end
  end
end