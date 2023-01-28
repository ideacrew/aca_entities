# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module H41
          # Happymapper implementation for the root object of an Request.
          class CoveredIndividual
            include HappyMapper
            register_namespace 'airty20a', 'urn:us:gov:treasury:irs:ext:aca:air:ty20a'
            register_namespace 'irs', 'urn:us:gov:treasury:irs:common'

            tag 'CoveredIndividual'
            namespace 'airty20a'

            has_one :InsuredPerson, InsuredPerson
            element :CoverageStartDt, String, tag: 'CoverageStartDt', namespace: "irs"
            element :CoverageEndDt, String, tag: 'CoverageEndDt', namespace: "irs"

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
